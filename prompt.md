### Custom prompt

You want a cool prompt, right ?
```shell
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="\[\e[38;5;151m\]\u\[\e[38;5;245m\]@\[\e[38;5;36m\]\h \e[1;7m\[\e[38;5;238m\]\A\e[0;27m \[\e[38;5;214m\]\w \[\e[38;5;161m\]\$(git_branch)\[\e[00m\]$ "
```

But you don't know how to read it, am I right ?

```shell
PS1="
	\[\e[38;5;151m\]\u		# username
	\[\e[38;5;245m\]@		# key '@'
	\[\e[38;5;36m\]\h 		# hostname
	\e[1;7m				# bold and inverted <=> \e[1m\e[7m	
		\[\e[38;5;238m\]\A	# HH:mm
	\e[0;27m 			# end of bold and inverted 
	\[\e[38;5;214m\]\w 		# working directory path
	\[\e[38;5;161m\]\$(git_branch)	# branch name or nothing
	\[\e[00m\]$ 			# back to normal
"
```

And you probably wonder what are all the control commands for `PS1` string...

```
d - the date in "Weekday Month Date" format (e.g., "Tue May 26")
e - an ASCII escape character (033)
h - the hostname up to the first .
H - the full hostname
j - the number of jobs currently run in background
l - the basename of the shells terminal device name
n - newline
r - carriage return
s - the name of the shell, the basename of $0 (the portion following the final slash)
t - the current time in 24-hour HH:MM:SS format
T - the current time in 12-hour HH:MM:SS format
@ - the current time in 12-hour am/pm format
A - the current time in 24-hour HH:MM format
u - the username of the current user
v - the version of bash (e.g., 4.00)
V - the release of bash, version + patch level (e.g., 4.00.0)
w - Complete path of current working directory
W - the basename of the current working directory
! - the history number of this command
# - the command number of this command
$ - if the effective UID is 0, a #, otherwise a $
nnn - the character corresponding to the octal number nnn
\ - a backslash
[ - begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
] - end a sequence of non-printing characters
```
Guess what ? [This](https://medium.com/@thucnc/how-to-show-current-git-branch-with-colors-in-bash-prompt-380d05a24745) could be what you are looking for.

Ok, now you know that, imagine a script that could display in a terminal **all the colours** !

```bash
#!/bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar.
# See http://sam.zoy.org/wtfpl/COPYING for more details.

for fgbg in 38 48 ; do # Foreground / Background
for color in {0..255} ; do # Colors
    # Display the color
    printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
    # Display 6 colors per lines
    if [ $((($color + 1) % 6)) == 4 ] ; then
        echo # New line
    fi
done
echo # New line
done

exit 0
```

Or... Idk, a script that presents you **various effects** you could use !

```bash
#!/bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. 
# See http://sam.zoy.org/wtfpl/COPYING for more details.

#Background
for clbg in {40..47} {100..107} 49 ; do
#Foreground
for clfg in {30..37} {90..97} 39 ; do
	#Formatting
	for attr in 0 1 2 4 5 7 ; do
		#Print the result
		echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
	done
	echo #Newline
done
done

exit 0
```

But, I know what you're saying right now... *does this really work ?*
Well, at least you could you can test your result in an `echo`.

Code | Description | Example
-----|-------------|--------
0 | Reset all attributes | `echo -e "\e[0mNormal Text"`
21 | Reset bold/bright | `echo -e "Normal \e[1mBold \e[21mNormal"`
22 | Reset dim | `echo -e "Normal \e[2mDim \e[22mNormal"`
24 | Reset underlined | `echo -e "Normal \e[4mUnderlined \e[24mNormal"`
25 | Reset blink | `echo -e "Normal \e[5mBlink \e[25mNormal"`
27 | Reset reverse | `echo -e "Normal \e[7minverted \e[27mNormal"`
28 | Reset hidden | `echo -e "Normal \e[8mHidden \e[28mNormal"`

You can **combine** the control commands!

Description | Code (Bash)
------------|------------
Bold + Underlined | `echo -e "\e[1;4mBold and Underlined"`
Bold + Red forground + Green background | `echo -e "\e[1;31;42m Yes it is awful \e[0m"`

#### Extras

Try:
- `echo -e "\e[38;5;82mHello \e[38;5;198mWorld"`
- `for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo`
- `echo -e "\e[40;38;5;82m Hello \e[30;48;5;82m World \e[0m"`
- `for i in {16..21} {21..16} ; do echo -en "\e[48;5;${i}m \e[0m" ; done ; echo`

#### FOREGROUND

Code | Color | Example
-----|-------|--------
39 | Default foreground color | `echo -e "Default \e[39mDefault"`
30 | Black | `echo -e "Default \e[30mBlack"`
31 | Red | `echo -e "Default \e[31mRed"`
32 | Green | `echo -e "Default \e[32mGreen"`
33 | Yellow | `echo -e "Default \e[33mYellow"`
34 | Blue | `echo -e "Default \e[34mBlue"`
35 | Magenta | `echo -e "Default \e[35mMagenta"`
36 | Cyan | `echo -e "Default \e[36mCyan"`
37 | Light gray | `echo -e "Default \e[37mLight gray"`
90 | Dark gray | `echo -e "Default \e[90mDark gray"`
91 | Light red | `echo -e "Default \e[91mLight red"`
92 | Light green | `echo -e "Default \e[92mLight green"`
93 | Light yellow | `echo -e "Default \e[93mLight yellow"`
94 | Light blue | `echo -e "Default \e[94mLight blue"`
95 | Light magenta | `echo -e "Default \e[95mLight magenta"`
96 | Light cyan | `echo -e "Default \e[96mLight cyan"`
97 | White | `echo -e "Default \e[97mWhite"`

#### BACKGROUND

Code | Color | Example
-----|-------|--------
49 | Default background color | `echo -e "Default \e[49mDefault"`
40 | Black | `echo -e "Default \e[40mBlack"`
41 | Red | `echo -e "Default \e[41mRed"`
42 | Green | `echo -e "Default \e[42mGreen"`
43 | Yellow | `echo -e "Default \e[43mYellow"`
44 | Blue | `echo -e "Default \e[44mBlue"`
45 | Magenta | `echo -e "Default \e[45mMagenta"`
46 | Cyan | `echo -e "Default \e[46mCyan"`
47 | Light gray | `echo -e "Default \e[47mLight gray"`
100 | Dark gray | `echo -e "Default \e[100mDark gray"`
101 | Light red | `echo -e "Default \e[101mLight red"`
102 | Light green | `echo -e "Default \e[102mLight green"`
103 | Light yellow | `echo -e "Default \e[103mLight yellow"`
104 | Light blue | `echo -e "Default \e[104mLight blue"`
105 | Light magenta | `echo -e "Default \e[105mLight magenta"`
106 | Light cyan | `echo -e "Default \e[106mLight cyan"`
107 | White | `echo -e "Default \e[107mWhite"`

Wanna know more about [how to use the colours](https://misc.flogisoft.com/bash/tip_colors_and_formatting) ?
