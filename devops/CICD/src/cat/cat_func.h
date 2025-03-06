#ifndef CAT_FUNC_H
#define CAT_FUNC_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void read_arguments(int argc, char *argv[], int *number_nonempty,
                    int *show_ends, int *number_all, int *space_compress,
                    int *tab_switch);
int print_line_number(int line_num, int number_nonempty, int number_all,
                      const char *line);
int print_line_compress(int *check_space, const char *line);
int print_line_with_tab_switch(int len, char *line);
int print_line_with_show_ends(int len, char *line);
int print_lines(FILE *fp, int number_nonempty, int show_ends, int number_all,
                int space_compress, int tab_switch);
int close_file(FILE *fp);

#endif
