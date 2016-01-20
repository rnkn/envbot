#! /usr/bin/env bash

function envbot_auto() {
    if [[ "$PWD" != "$ENVBOT_PWD" ]]
    then

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

        local _path="$PWD/"
        while [[ -n "$_path" ]]
        do
            _path="${_path%/*}"
            local _env="${_path}/.env"

            if [[ -r "$_env" ]]
            then
                while IFS="=" read -r name value
                do
                    local _name=$(eval echo "$name")
                    local _value=$(eval echo "$value")
                    local _globalvalue="${!_name}"
                    local _set

                    if [[ "$_value" != "$_globalvalue" ]]
                    then
                        for line in ${ENVBOT_TMP[@]}
                        do
                            if [[ "$line" =~ ^$_name ]]
                            then
                                _set=0
                                break
                            fi
                        done
                        if [[ ! $_set ]]
                        then
                            ENVBOT_TMP+=("$_name=$_globalvalue")
                            export $_name="$_value"
                            # printf "envbot: Set %s=%s\n" "$_name" "$_value"
                        fi
                    fi
                done < "$_env"
            fi
        done
        ENVBOT_PWD="$PWD"
    fi
}

export PROMPT_COMMAND=envbot_auto
