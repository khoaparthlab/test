# Problem in FF



## Contents

[TOC]

## Limitation  

 - Only can compare the Enum from json. Can't apply Enum into directly
 - When you want to custom native, you need to download FF pj down, then custom and merge it back to the FF branch
 - Limited of inject variable into a component
 - Hard to seperate the big screen to smaller screen -> make confuse in 1 file of screen really big if have many feature
 - Can't add library into custom function
 - html library can't use in web platform
 - FF have cant convert when custom import library web/mobile


## What should custom in FF
 - Convert type of state data to use Enum
 - Setting up the native function
 - Retriction on the use of AppState
 - Set the Return for Custom Action
 - custom import library when using html

## Notice
 - Custom function is for utils function
 - Custom action for repository function