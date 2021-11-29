autoload -Uz add-zsh-hook

# Cursor style
# Settings:
#  1 -> blinking block
#  2 -> solid block 
#  3 -> blinking underscore
#  4 -> solid underscore
#  5 -> blinking vertical bar
#  6 -> solid vertical bar
.prompt.cursor.executing() { print -n '\e[3 q'; true }
.prompt.cursor.cmd()       { print -n '\e[1 q'; true }
add-zsh-hook preexec .prompt.cursor.executing  # when executing a command
add-zsh-hook precmd  .prompt.cursor.cmd        # when the command line is active
.prompt.cursor.cmd

# Whenever we change dirs, prompt the new directory.
setopt cdsilent pushdsilent  # Suppress built-in output of cd and pushd.
.prompt.chpwd() {
  zle && zle -I                 # Prepare the line editor for our output.
  # print -P -- '\n%F{7}%~%f/'   # -P expands prompt escape codes.
  RPS1=
  zle && [[ $CONTEXT == start ]] &&
      .prompt.git-status.async  # Update git status, if on primary prompt.
  true  # Always return true; otherwise, the next hook will not run.
}
add-zsh-hook chpwd .prompt.chpwd
.prompt.chpwd
 

PS1='%F{8}┌[%B%F{1}%n%b%F{2}@%F{4}%m%F{8}] %F{5}> %F{7}%~ 
%F{8}└%F{%(?,5,3)}$%f '
#
ZLE_RPROMPT_INDENT=0     # Right prompt margin
setopt transientrprompt  # Auto-remove the right side of each prompt.

# Reduce prompt latency by fetching git status asynchronously.
add-zsh-hook precmd .prompt.git-status.async
.prompt.git-status.async() {
  local fd=
  exec {fd}< <( .promp.git-status.parse )
  zle -Fw "$fd" .prompt.git-status.callback

  true  # Always return true; otherwise, the next hook will not run.
}

.promp.git-status.parse() {
  local -a lines=() symbols=() tmp=()
  local REPLY= MATCH= MBEGIN= MEND= head= gitdir= push= upstream= ahead= behind=
  {
    gitdir="$( git rev-parse -q --git-dir 2> /dev/null )" ||
        return

    # Capture the left-most group of non-blank characters on each line.
    lines=( ${(f)"$( git status -sunormal )"} )
    REPLY=${(SMj::)lines[@]##[^[:blank:]]##}

    # Split on color reset escape code, discard duplicates and sort.
    symbols=( ${(ps:\e[m:ui)REPLY//'??'/?} )

    REPLY=${(pj:\e[m :)symbols}$'\e[m'  # Join with color resets.
    REPLY+=" %F{12}${$( git rev-parse -q --show-toplevel ):t}%f:"  # Add repo root dir

    if head=$( git branch --show-current 2> /dev/null ) && [[ -n $head ]]; then
      REPLY+="%F{14}$head%f"

      if upstream=$( git rev-parse -q --abbrev-ref @{u} 2> /dev/null ) && [[ -n $upstream ]]; then
        git config --local \
            remote.$upstream:h.fetch '+refs/heads/*:refs/remotes/'$upstream:h'/*'
        [[ -z $gitdir/FETCH_HEAD(Nmm-1) ]] &&
            git fetch -qt  # Fetch if there's no FETCH_HEAD or it is at least 1 minute old.

        upstream=${${upstream%/$head}#upstream/}
        behind=${$( git rev-list --count --right-only @...@{u} ):#0}
        REPLY+=" %F{13}${behind:+%B$behind}%f<-"

        if push=${${"$( git rev-parse -q --abbrev-ref @{push} 2> /dev/null )"%/$head}#origin/}
        then
          if [[ $push != $upstream ]]; then
            ahead=${$( git rev-list --count --left-only @...@{push} ):#0}
            REPLY+="%F{13}$upstream%b%f %F{14}${ahead:+%B$ahead}%f->%F{13}$push%b%f"
          else
            ahead=${$( git rev-list --count --left-only @...@{u} ):#0}
            if [[ -z $ahead && -z $behind ]]; then
              REPLY+="> %F{13}$upstream%b%f"
            else
              REPLY+="%b%f %F{14}${ahead:+%B$ahead}%f-> %F{13}$upstream%b%f"
            fi
          fi
        else
          REPLY+="%F{13}$upstream%b%f"
        fi
      fi
    elif head="$( git branch -q --no-color --points-at=@ 2> /dev/null )"; then
      REPLY+="%F{1}${${head##*\((no branch, |)}%\)*}"
    else
      REPLY+="%F{14}${"$( < $gitdir/HEAD )":t}%f"
    fi

    # Wrap ANSI codes in %{prompt escapes%}, so they're not counted as printable characters.
    REPLY="${REPLY//(#m)$'\e['[;[:digit:]]#m/%{${MATCH}%\}}"
  } always {
    print -r -- "$REPLY"
  }
}

zle -N .prompt.git-status.callback
.prompt.git-status.callback() {
  local fd=$1 REPLY
  {
    zle -F "$fd"            # Unhook this callback to avoid being called repeatedly.
    read -ru $fd
    [[ $RPS1 == $REPLY ]] &&
        return              # Avoid repainting when there's no change.
    RPS1=$REPLY
    zle && [[ $CONTEXT == start ]] &&
        zle .reset-prompt   # Repaint only if $RPS1 is actually visible.
  } always {
    exec {fd}<&-            # Close the file descriptor.
  }
}

# Shown after output that doesn't end in a newline.
PROMPT_EOL_MARK='%F{cyan}%S%#%f%s'

# Continuation prompt
indent=( '%('{1..36}'_,  ,)' )
PS2="${(j::)indent}" RPS2='%F{11}%^'

# Debugging prompt
indent=( '%('{1..36}"e,$( echoti cuf 2 ),)" )
i=${(j::)indent}
PS4=$'%(?,,\t\t-> %F{9}%?%f\n)'
PS4+=$'%2<< %{\e[2m%}%e%22<<             %F{10}%N%<<%f %3<<  %I%<<%b %(1_,%F{11}%_%f ,)'

unset indent
