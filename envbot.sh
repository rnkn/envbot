function envbot_check() {
    for line in $1
    do
        local _name="${line%%=*}"
        local _value="${line##*=}"
        if [ "$_name" == "$2" ]
        then
            return 1
            break
        fi
    done
    return 0
}

function envbot_auto() {
    if [ "$PWD" != "$OLDPWD" ]
    then
        local _env="$PWD/.env"
        if [ -r "$_env" ]
        then
            while IFS="=" read -r name value
            do
                local _name=$(eval echo "$name")
                local _value=$(eval echo "$value")

                if [ "$_value" != "${!_name}" ]
                then
                    if envbot_check $ENVBOT_TMP $_name
                    then
                        ENVBOT_TMP=$(echo -e "$ENVBOT_TMP\n$_name=${!_name}")
                    fi
                    export "$_name"="$_value"
                fi
            done < $_env
        else
            source "$HOME/.bash_profile"
        fi
    fi
}

export PROMPT_COMMAND=envbot_auto
