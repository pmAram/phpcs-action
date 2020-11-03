#!/bin/sh

if [ -z $STANDARD ]; then
  STANDARD=Symfony
fi

if [ -z $MEM_LIMIT ]; then
  MEM_LIMIT=512M
fi

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

if [ -n "${INPUT_INSTALLED_PATHS}" ]; then
    ${INPUT_PHPCS_BIN_PATH} --config-set installed_paths "${INPUT_INSTALLED_PATHS}"
fi

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} -d memory_limit=$MEM_LIMIT --standard=$STANDARD -n --report=checkstyle
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} -d memory_limit=$MEM_LIMIT --standard=$STANDARD --report=checkstyle
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
