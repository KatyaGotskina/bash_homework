#!/bin/bash 
count_errors=0
function authorization() {
    for i in 1 2 3
    do
        read -p 'Введите логин: ' login
        read -s -t 5 -p 'Введите пароль: ' pswrd

        flag=0
        counter=1
        counter_for_pswd=1

        while read some_login
        do
            if [[ $some_login == $login ]]
            then
                while read some_password
                do
                if [[ $counter -eq $counter_for_pswd ]]
                then 
                    hash=$(echo $pswrd | md5sum)
                    for i in $hash
                    do
                        if [[ $i == $some_password ]]
                        then
                        echo Успешная авторизация 
                        return 0 
                        else
                        echo Неправильный пароль
                        flag=1
                        echo Ошибка авторизации: неверный пароль >> authorization_errors
                        count_errors=$(($count_errors+1))
                        fi 
                    break
                    done

                fi
                counter_for_pswd=$(($counter_for_pswd+1))
                done < passwords
            fi
        counter=$(($counter+1))
        done < logins
        if [[ $flag -eq 0 ]]
        then
            echo Ошибка авторизации: логин не существует >> authorization_errors
            echo Неправильный логин
            count_errors=$(($count_errors+1))
        fi
        if [[ $count_errors -eq 3 ]]
        then
        echo Неуспешная авторизация >> no_authorization
        fi
    done
}

authorization $login $pswrd