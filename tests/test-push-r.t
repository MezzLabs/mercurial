  $ hg init test
  $ cd test

  $ cat >>afile <<EOF
  > 0
  > EOF
  $ hg add afile
  $ hg commit -m "0.0"

  $ cat >>afile <<EOF
  > 1
  > EOF
  $ hg commit -m "0.1"

  $ cat >>afile <<EOF
  > 2
  > EOF
  $ hg commit -m "0.2"

  $ cat >>afile <<EOF
  > 3
  > EOF
  $ hg commit -m "0.3"

  $ hg update -C 0
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved

  $ cat >>afile <<EOF
  > 1
  > EOF
  $ hg commit -m "1.1"
  created new head

  $ cat >>afile <<EOF
  > 2
  > EOF
  $ hg commit -m "1.2"

  $ cat >fred <<EOF
  > a line
  > EOF
  $ cat >>afile <<EOF
  > 3
  > EOF
  $ hg add fred
  $ hg commit -m "1.3"

  $ hg mv afile adifferentfile
  $ hg commit -m "1.3m"

  $ hg update -C 3
  1 files updated, 0 files merged, 2 files removed, 0 files unresolved

  $ hg mv afile anotherfile
  $ hg commit -m "0.3m"

  $ hg debugindex .hg/store/data/afile.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0       3      0       0 362fef284ce2 000000000000 000000000000
       1         3       5      1       1 125144f7e028 362fef284ce2 000000000000
       2         8       7      2       2 4c982badb186 125144f7e028 000000000000
       3        15       9      3       3 19b1fc555737 4c982badb186 000000000000

  $ hg debugindex .hg/store/data/adifferentfile.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0      75      0       7 2565f3199a74 000000000000 000000000000

  $ hg debugindex .hg/store/data/anotherfile.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0      75      0       8 2565f3199a74 000000000000 000000000000

  $ hg debugindex .hg/store/data/fred.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0       8      0       6 12ab3bcc5ea4 000000000000 000000000000

  $ hg debugindex .hg/store/00manifest.i
     rev    offset  length   base linkrev nodeid       p1           p2
       0         0      48      0       0 43eadb1d2d06 000000000000 000000000000
       1        48      48      1       1 8b89697eba2c 43eadb1d2d06 000000000000
       2        96      48      2       2 626a32663c2f 8b89697eba2c 000000000000
       3       144      48      3       3 f54c32f13478 626a32663c2f 000000000000
       4       192      58      3       6 de68e904d169 626a32663c2f 000000000000
       5       250      68      3       7 09bb521d218d de68e904d169 000000000000
       6       318      54      6       8 1fde233dfb0f f54c32f13478 000000000000

  $ hg verify
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  4 files, 9 changesets, 7 total revisions

  $ cd ..

  $ for i in 0 1 2 3 4 5 6 7 8; do
  >    echo
  >    mkdir test-"$i"
  >    hg --cwd test-"$i" init
  >    hg -R test push -r "$i" test-"$i"
  >    cd test-"$i"
  >    hg verify
  >    cd ..
  > done
  
  pushing to test-0
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 1 changesets with 1 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 1 changesets, 1 total revisions
  
  pushing to test-1
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 2 changesets with 2 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 2 changesets, 2 total revisions
  
  pushing to test-2
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 3 changesets with 3 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 3 changesets, 3 total revisions
  
  pushing to test-3
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 4 changesets with 4 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 4 changesets, 4 total revisions
  
  pushing to test-4
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 2 changesets with 2 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 2 changesets, 2 total revisions
  
  pushing to test-5
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 3 changesets with 3 changes to 1 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  1 files, 3 changesets, 3 total revisions
  
  pushing to test-6
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 4 changesets with 5 changes to 2 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  2 files, 4 changesets, 5 total revisions
  
  pushing to test-7
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 5 changesets with 6 changes to 3 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  3 files, 5 changesets, 6 total revisions
  
  pushing to test-8
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 5 changesets with 5 changes to 2 files
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  2 files, 5 changesets, 5 total revisions

  $ cd test-8

  $ hg pull ../test-7
  pulling from ../test-7
  searching for changes
  adding changesets
  adding manifests
  adding file changes
  added 4 changesets with 2 changes to 3 files (+1 heads)
  (run 'hg heads' to see heads, 'hg merge' to merge)

  $ hg verify
  checking changesets
  checking manifests
  crosschecking files in changesets and manifests
  checking files
  4 files, 9 changesets, 7 total revisions

