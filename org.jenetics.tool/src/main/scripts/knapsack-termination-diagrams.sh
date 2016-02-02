#!/usr/bin/env bash

read_link() {
	local path=$1
	if [ -d ${path} ] ; then
		local abspath=$(cd ${path}; pwd)
	else
		local prefix=$(cd $(dirname -- ${path}); pwd)
		local suffix=$(basename ${path})
		local abspath="$prefix/$suffix"
	fi
	echo ${abspath}
}

RESULTS=(
	"Knapsack-execution_time_termination.xml"
	"Knapsack-fitness_threshold_termination.xml"
	"Knapsack-fixed_generation_termination.xml"
	"Knapsack-steady_fitness_termination.xml"
)

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
RESULT_BASE_PATH=`read_link "${SCRIPT_DIR}/../results/org/jenetics/tool/evaluation"`
JRUN=`read_link "${SCRIPT_DIR}/../../../../jrun"`

for item in ${RESULTS[@]}
do
	RESULT="${RESULT_BASE_PATH}/${item}"
	${JRUN} org.jenetics.tool.evaluation.Diagram --input ${RESULT}
done
