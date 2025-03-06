# output.sh

# Вывод информации
echo "Total number of folders (including all nested ones) = $total_folders"
echo
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders_output"
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $config_files"
echo "Text files = $text_files"
echo "Executable files = $executable_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symbolic_links"
echo
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top_files_output"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash)"
echo "$top_executable_files_output"
echo "Script execution time (in seconds) = $execution_time"
