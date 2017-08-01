# Mysqldump view reorder


In case you have hierarchical views (views referencing other views), import of mysqldump output may not work, since mysqldump doesn't care about hierarchical order of views. Create operation then fails for view which selects data from view which doesn't exist yet.

This script solves this problem by reordering of views in mysqldump output.

You can pass mysqldump file as parameter, or pipe its output to this script through stdout/stdin.
