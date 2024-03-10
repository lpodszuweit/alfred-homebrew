#!/usr/bin/env zsh

# quick hack to show outdated cask/formula in alfred
# should become somewhat more alfredesque, e.g. list of items like with install
# needs options for update all from this list, e.g. eject a pseudo package into item list
# also, first contact here with zsh variables and tests..

local casks=()
local formula=()
local bu_result

bu_result=("${(@f)$(brew update)}")
casks=("${(@f)$(brew outdated --casks)}") # this makes the output an array of lines
formula=("${(@f)$(brew outdated --formulae)}")

printf "\nbrew update:\n%s\n" "$bu_result[@]"
for i ("$bu_result[@]") print -r -- $i


if (( $#casks + $#formula < 1 )); then
    printf "\noNo casks or formulae to update\n"
else
    if (($#casks > 0)); then
        printf "\nThere are %d casks to update:\n" ${#casks}
        for line in $casks; do
            echo $line
        done
    else
        echo "No casks to update"
    fi

    if (($#formula > 0)); then
        printf '\nThere are %d formula to update:\n' ${#formula}
        for line in $formula; do
            echo $line
        done
    else
        echo "No formulae to update"
    fi
fi
