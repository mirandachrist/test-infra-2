lint:
	@scripts/run_golangci.sh
	@scripts/check_license.sh
	@bazel run //:buildifier -- -showlog -mode=check $(git ls-files| grep -e BUILD -e WORKSPACE | grep -v vendor)

.PHONY: testgrid
testgrid:
	configurator --prow-config prow/config.yaml --prow-job-config prow/cluster/jobs --output-yaml --yaml testgrid/default.yaml --oneshot --output testgrid/istio-generated.yaml

generate-config:
	(cd prow/config/cmd; go run generate.go write)

diff-config:
	(cd prow/config/cmd; go run generate.go diff)

check-config:
	(cd prow/config/cmd; go run generate.go check)

include Makefile.common.mk
