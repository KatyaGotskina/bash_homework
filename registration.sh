#!/bin/bash
while [[ 2 -eq 2 ]]
    do
        read -p 'Введите логин: ' login

        while read some_login
        do
            if [[ $some_login == $login ]]
            then
                login='Такой логин уже существует. Введите новый логин'
            fi
            counter=$(($conter+1))
        done < logins
        if [[ $login == 'Такой логин уже существует. Введите новый логин' ]]
        then
            echo $login
            continue 
        else
            read -s -p 'Введите пароль: ' pswrd
            echo $login  >> logins
            hash=$(echo $pswrd | md5sum)
            for i in $hash
            do
                echo $i >> passwords
                echo Вы успешно зарегистрированы!
                break
            done
        fi
        break
    done

