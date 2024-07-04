# Intruction token security

## Content

[TOC]

## Library
```
Library:
 flutter_secure_storage: 9.2.2 // use for enscryption token storage
 http: 1.2.1 // get IP of device login in
 uuid: 4.4.0 // get deviceID of device login in
```
References: https://github.com/khoaparthlab/test
In this code, In the first start the web you won't see anything because it didn't have ip or id yet, load again then you will see, that when ip or id already setted in secure local, you can see the content

## Secure Flow
Reference: https://app.diagrams.net/#G1nd4mY4Bx8aXn5Mpg-o0wcD5-IFL9BQ3w#%7B%22pageId%22%3A%22C5RBs43oDa-KdzZeNtuy%22%7D
### Signin Flow
```flow
st=>start: Open website
ip=>operation: Input email, password
cond=>condition: Is correct password ?
op=>condition: Warning incorect more than 8 times
lock=>operation: Lock account 1 day
e=>end: Sign in
sav=>operation: Save the token + DeviceID/IP into secure storage

st->ip->cond
op->ip
op(no)->ip
op(yes)->lock
cond(yes)->sav->e
cond(no)->op
```
### Remember password Flow
```flow
st=>start: Open website
ip=>operation: Delete storage
cond=>condition: Has token storage ?
op=>condition: DeviceID/IP storage = DeviceID/IP current ?
lock=>operation: Lock account 1 day
no=>operation: Do nothing
e=>end: Signin
no2=>operation: Back to signin page

st->cond
op->ip
op(no)->ip->no2
op(yes)->e
cond(yes)->op
cond(no)->no

```
## Notice
```
Should check device is Application or Web to use right function
Web only can get IP, Real device can get ID to more security
Secure hash follow sha256

```