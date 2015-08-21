# Mysqldump view reorder


In case you have hierarchical views (views referencing other views), import of mysqldump output may not work, since mysqldump doesn't care of correct order of views in this case and creation of views which tries to pull data from view which doesn't exist doesn't work.

This script solves this problem by reordering of views in mysqldump output.

You can pass mysqldump file as parameter, or pipe its output to this script through stdout/stdin.
