#!/bin/bash
: '
Write a shell script that implements a password validator. The rules for the validator are as follows:
1. Password length should be at least 8 characters
2. Should contain alphabets and numbers
3. Should contain both uppercase and lowercase letters

Input: sample password
Output: "Strong Password" (if conditions are met)
            "Weak Password" (if conditions are not met) 
'
echo "Please enter the password:"
read password

if [[ $(echo ${#password}) -ge 8 ]] && [[ $password == *[A-Z]* ]]  && [[ $password == *[a-z]* ]] && [[ $password == *[0-9]* ]] ; then 
  echo "Strong Password"
else 
  echo "Weak Password"
fi
