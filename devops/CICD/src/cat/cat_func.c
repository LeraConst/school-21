#include "cat_func.h"

void read_arguments(int argc, char *argv[], int *number_nonempty,
                    int *show_ends, int *number_all, int *space_compress,
                    int *tab_switch) {
  int opt;

  static struct option long_options[] = {
      {"number", no_argument, 0, 'n'},
      {"show-ends", no_argument, 0, 'e'},
      {"show-tabs", no_argument, 0, 't'},
      {"squeeze-blank", no_argument, 0, 's'},
      {"number-nonblank", no_argument, 0, 'b'},
      {0, 0, 0, 0}};

  while ((opt = getopt_long(argc, argv, "netsb", long_options, NULL)) != -1) {
    switch (opt) {
      case 'n':
        *number_all = 1;
        break;
      case 'e':
        *show_ends = 1;
        break;
      case 't':
        *tab_switch = 1;
        break;
      case 's':
        *space_compress = 1;
        break;
      case 'b':
        *number_nonempty = 1;
        break;
      default:
        return;
    }
  }
}

int print_line_number(int line_num, int number_nonempty, int number_all,
                      const char *line) {
  if (number_nonempty) {
    if (line[0] != '\n') {
      printf("%6d\t", line_num);
      line_num++;
    }
  } else if (number_all) {
    printf("%6d\t", line_num);
    line_num++;
  }
  return line_num;
}

int print_line_compress(int *check_space, const char *line) {
  int exit = 0;
  if (line[0] == '\n' && *check_space != 1) {
    exit = 1;
  } else if (line[0] == '\n') {
    *check_space = *check_space + 1;
  } else {
    *check_space = 1;
  }
  return exit;
}

int print_line_with_tab_switch(int len, char *line) {
  for (int k = 0; k < len; k++) {
    if (line[k] == '\t') {
      line[k] = 'I';
      printf("^");
    }
    printf("%c", line[k]);
  }
  return 0;
}

int print_line_with_show_ends(int len, char *line) {
  if (len > 0 && line[len - 1] == '\n') {
    line[len - 1] = '\0';
    printf("%s$\n", line);
  } else {
    printf("%s", line);
  }
  return 0;
}

int print_lines(FILE *fp, int number_nonempty, int show_ends, int number_all,
                int space_compress, int tab_switch) {
  char *line = NULL;
  size_t line_len = 0;
  ssize_t read_len;

  int line_num = 1;
  int check_space = 1;
  while ((read_len = getline(&line, &line_len, fp)) != -1) {
    line_num = print_line_number(line_num, number_nonempty, number_all, line);
    if (space_compress) {
      if (print_line_compress(&check_space, line)) {
        continue;
      }
    }
    if (tab_switch) {
      int len = strlen(line);
      print_line_with_tab_switch(len, line);
    } else if (show_ends) {
      int len = strlen(line);
      print_line_with_show_ends(len, line);
    } else {
      printf("%s", line);
    }
  }

  free(line);
  return 0;
}

int close_file(FILE *fp) {
  if (fp != stdin) {
    fclose(fp);
  }
  return 0;
}
