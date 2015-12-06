#! /bin/bash

function envbot_auto() {
    if [[ "$PWD" != "$ENVBOT_PWD" ]]
    then
        local _env="$PWD/.env"

        for line in ${ENVBOT_TMP[@]}
        do
            local _name="${line%%=*}"
            local _value="${line##*=}"
            local _globalvalue="${!_name}"

            if [[ "$_value" != "$_globalvalue" ]]
            then
                export $_name="$_value"
            fi
        done

        unset ENVBOT_TMP

        if [[ -r "$_env" ]]
        then
            while IFS="=" read -r name value
            do
                local _name=$(eval echo "$name")
                local _value=$(eval echo "$value")
                local _globalvalue="${!_name}"

                if [[ "$_value" != "$_globalvalue" ]]
                then
                    for line in ${ENVBOT_TMP[@]}
                    do
                        if [[ "$line" =~ ^$_name ]]
                        then
                            local _envbot_set=0
                            break
                        fi
                    done
                    if [[ ! $_envbot_set ]]
                    then
                        ENVBOT_TMP+=("$_name=$_globalvalue")
                    fi
                    export $_name="$_value"
                    echo "envbot: $_name=$_value"
                fi
            done < $_env
        fi
        ENVBOT_PWD="$PWD"
    fi
}

export PROMPT_COMMAND=envbot_auto
