#!/in/bash

remote_id=$(
    xinput list |
        sed -n 's/.*Asus.*id=\([0-9]*\).*keyboard.*/\1/p'
)
[ "$remote_id" ] || exit

mkdir -p /tmp/xkb/symbols
# This is a name for the file, it could be anything you
# want. For us, we'll name it "custom". This is important
# later.
#
# The KP_* come from /usr/include/X11/keysymdef.h
# Also note the name, "remote" is there in the stanza
# definition.
cat >/tmp/xkb/symbols/custom <<\EOF

xkb_symbols "remote" {
    key <AB05> {};
};
EOF

# (1) We list our current definition
# (2) Modify it to have a keyboard mapping using the name
#     we used above, in this case it's the "remote" definition
#     described in the file named "custom" which we specify in
#     this world as "custom(remote)".
# (3) Now we take that as input back into our definition of the
#     keyboard. This includes the file we just made, read in last,
#     so as to override any prior definitions.  Importantly we
#     need to include the directory of the place we placed the file
#     to be considered when reading things in.
#
setxkbmap -device $remote_id -print |
    sed 's/\(xkb_symbols.*\)"/\1+custom(remote)"/' |
    xkbcomp -I/tmp/xkb -i $remote_id -synch - $DISPLAY 2>/dev/null

notify-send 'Disabled ASUS B key.'
