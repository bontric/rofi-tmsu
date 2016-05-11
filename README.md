# rofi-tmsu
This is a small script to integrate [TMSU](https://github.com/oniony/TMSU) with [rofi](https://davedavenport.github.io/rofi//index.html) 

### Configure
+ `OPEN` :  Set Program to open files (Default [xdg-open](http://linux.die.net/man/1/xdg-open)) 
+ `CWD` : Set working directory (File paths are shown in relation to this path)
+ `TMSU_DB` : Set the location of your TMSU database (**Full path!**)

### Set Up (i3)
Make the script executable:
```sh
chmod +x rofi-tmsu.sh
```

Add:
```sh
bindsym $mod+Shift+d exec rofi -modi "tmsu:/path/to/rofi-tmsu.sh" -show tmsu
```                                                                     
to your i3 config file. (Change `$mod+Shift+d` to whatever combination you prefer )


### Usage
You will be prompted with all available tags. Just  type one or more tags (separated by space)
and hit enter. Type again to search through the available files. Hit enter again to open the selected file.
