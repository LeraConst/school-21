#include "func_grep.h"

void process_arguments(int argc, char* argv[], bool* regexp, bool* ignore_case,
                       bool* invert_match, bool* count_lines,
                       bool* print_filenames, bool* print_line_number,
                       bool* no_filename, bool* show_messages,
                       bool* only_matching) {
  while (true) {
    static struct option long_options[] = {
        {"regexp", no_argument, 0, 'e'},
        {"ignore-case", no_argument, 0, 'i'},
        {"invert-match", no_argument, 0, 'v'},
        {"count", no_argument, 0, 'c'},
        {"files-with-matches", no_argument, 0, 'l'},
        {"line-number", no_argument, 0, 'n'},
        {"no-filename", no_argument, 0, 'h'},
        {"show-messages", no_argument, 0, 's'},
        {"only-matching", no_argument, 0, 'o'},
        {0, 0, 0, 0}};
    int option_index = 0;
    int opt = getopt_long(argc, argv, "eivclnhso", long_options, &option_index);

    if (opt == -1) {
      break;
    }

    switch (opt) {
      case 'e':
        *regexp = true;
        break;
      case 'i':
        *ignore_case = true;
        break;
      case 'v':
        *invert_match = true;
        break;
      case 'c':
        *count_lines = true;
        break;
      case 'l':
        *print_filenames = true;
        break;
      case 'n':
        *print_line_number = true;
        break;
      case 'h':
        *no_filename = true;
        break;
      case 's':
        *show_messages = true;
        break;
      case 'o':
        *only_matching = true;
        break;
      default:
        return;
    }
  }
}

void search_files(const char* pattern, int argc, char* argv[],
                  bool show_messages, bool print_filenames, bool count_lines,
                  bool no_filename, bool ignore_case, bool invert_match,
                  bool print_line_number, bool only_matching) {
  int file_count = count_files(argc);

  for (int i = optind + 1; i < argc; i++) {
    const char* filename = argv[i];
    FILE* file = fopen(filename, "r");

    if (file == NULL) {
      if (!show_messages) {
        printf("Error: cannot open file %s.\n", filename);
      }
      continue;
    }
    if (print_filenames) {
      filename_print(file, pattern, filename);
    } else {
      if (file_count > 1 && !no_filename) {
        if (count_lines) {
          printf("%s:", filename);
        }
      }
      process_file(file, pattern, filename, file_count, ignore_case,
                   invert_match, count_lines, print_line_number, no_filename,
                   only_matching);
    }
    fclose(file);
  }
}

int count_files(int argc) {
  int count = 0;

  for (int i = optind + 1; i < argc; i++) {
    count++;
  }
  return count;
}

void filename_print(FILE* file, const char* pattern, const char* filename) {
  char* line = NULL;
  size_t line_lenght = 0;

  while (getline(&line, &line_lenght, file) != -1) {
    if (match_pattern(line, pattern, false)) {
      printf("%s\n", filename);
      break;
    }
  }
}

void process_file(FILE* file, const char* pattern, const char* filename,
                  int count, bool ignore_case, bool invert_match,
                  bool count_lines, bool print_line_number, bool no_filename,
                  bool only_matching) {
  char* line = NULL;
  size_t line_length = 0;
  int line_number = 0;
  int match_count = 0;

  while (getline(&line, &line_length, file) != -1) {
    line_number++;

    if (match_pattern(line, pattern, ignore_case) != invert_match) {
      if (count_lines) {
        match_count++;
      } else {
        if (count > 1 && !no_filename) {
          if (print_line_number) {
            if (only_matching) {
              for (int i = 0;
                   i < count_pattern_matches(line, pattern, ignore_case); i++) {
                printf("%s:%d:%s\n", filename, line_number, pattern);
              }
            } else {
              printf("%s:%d:%s", filename, line_number, line);
              print_enter_last_line(line);
            }
          } else {
            if (only_matching) {
              for (int i = 0;
                   i < count_pattern_matches(line, pattern, ignore_case); i++) {
                printf("%s:%s\n", filename, pattern);
              }
            } else {
              printf("%s:%s", filename, line);
              print_enter_last_line(line);
            }
          }
        } else if (count == 1 || no_filename) {
          if (print_line_number) {
            if (only_matching) {
              for (int i = 0;
                   i < count_pattern_matches(line, pattern, ignore_case); i++) {
                printf("%d:%s\n", line_number, pattern);
              }
            } else {
              printf("%d:%s", line_number, line);
              print_enter_last_line(line);
            }
          } else if (only_matching) {
            for (int i = 0;
                 i < count_pattern_matches(line, pattern, ignore_case); i++) {
              printf("%s\n", pattern);
            }
          } else {
            printf("%s", line);
            print_enter_last_line(line);
          }
        }
      }
    }
  }
  if (count_lines) {
    printf("%d\n", match_count);
  }
  free(line);
}

void print_enter_last_line(char* line) {
  if (strstr(line, "\n") == NULL) {
    printf("\n");
  }
}

bool match_pattern(const char* line, const char* pattern, bool ignore_case) {
  bool rtn = strstr(line, pattern) != NULL;
  if (ignore_case) {
    rtn = strcasestr(line, pattern) != NULL;
  }
  return rtn;
}

char* strcasestr(const char* haystack, const char* needle) {
  if (*needle == '\0') {
    return (char*)haystack;
  }

  while (*haystack != '\0') {
    size_t i = 0;

    while (tolower(haystack[i]) == tolower(needle[i])) {
      if (needle[i + 1] == '\0') {
        return (char*)haystack;
      }
      i++;
    }

    haystack++;
  }

  return NULL;
}

int count_pattern_matches(const char* line, const char* pattern,
                          bool ignore_case) {
  int rtn = 1;
  size_t line_length = strlen(line);
  size_t pattern_length = strlen(pattern);

  if (pattern_length == 0) {
    rtn = 0;
  }
  if (rtn != 0) {
    int count = 0;
    for (size_t i = 0; i <= line_length - pattern_length; i++) {
      bool match = true;
      for (size_t j = 0; j < pattern_length; j++) {
        if (!ignore_case) {
          if (line[i + j] != pattern[j]) {
            match = false;
            break;
          }
        } else {
          if (tolower(line[i + j]) != tolower(pattern[j])) {
            match = false;
            break;
          }
        }
      }
      if (match) {
        count++;
      }
    }
    rtn = count;
  }
  return rtn;
}
