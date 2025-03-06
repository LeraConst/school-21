#ifndef FUNC_GREP_H
#define FUNC_GREP_H

#include <ctype.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool match_pattern(const char* line, const char* pattern, bool ignore_case);
char* strcasestr(const char* haystack, const char* needle);
int count_files(int argc);
void print_enter_last_line(char* line);
void filename_print(FILE* file, const char* pattern, const char* filename);
void process_file(FILE* file, const char* pattern, const char* filename,
                  int count, bool ignore_case, bool invert_match,
                  bool count_lines, bool print_line_number, bool no_filename,
                  bool only_matching);
int count_pattern_matches(const char* line, const char* pattern,
                          bool ignore_case);
void process_arguments(int argc, char* argv[], bool* regexp, bool* ignore_case,
                       bool* invert_match, bool* count_lines,
                       bool* print_filenames, bool* print_line_number,
                       bool* no_filename, bool* show_messages,
                       bool* only_matching);
void search_files(const char* pattern, int argc, char* argv[],
                  bool show_messages, bool print_filenames, bool count_lines,
                  bool no_filename, bool ignore_case, bool invert_match,
                  bool print_line_number, bool only_matching);

#endif
