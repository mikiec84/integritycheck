#!/bin/bash
# integritycheck - https://github.com/asmuth/integritycheck
# Copyright (c) 2018, Paul Asmuth <paul@asmuth.com>
#
# This file is part of the "integritycheck" project. integritycheck is free software
# licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.
set -uex

source test/test-util.sh
mkdir "${TEST_TMPDIR}/repo"
cd "${TEST_TMPDIR}/repo"

echo "XXX" > testA
echo "XXX" > testB
echo "XXX" > testC

touch -m --date='2016-01-01 06:00:00' testA
touch -m --date='2016-01-01 06:00:00' testB
touch -m --date='2016-01-01 06:00:00' testC

ic init
ic status -v

mv testA testB1
mv testB testA1

if ic status --colours=off > "../status.raw"; then
  echo "exit code must be one"
  exit 1
fi

cat "../status.raw" | grep -vE "^Repository" | grep -vE "^Last Snapshot" > "../status"

(cat > "../status.expected") <<EOF
Total Size: 12B (3 files)
Status: DIRTY

    deleted  "testB"
    renamed  "testA" -> "testA1"
    renamed  "testA" -> "testB1"

EOF

diff "../status" "../status.expected"

sleep 0.01

ic ack -y .
ic status
