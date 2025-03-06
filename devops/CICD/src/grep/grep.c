#include "func_grep.h"

int main(int argc, char* argv[]) {
  bool regexp = false;
  bool ignore_case = false;
  bool invert_match = false;
  bool count_lines = false;
  bool print_filenames = false;
  bool print_line_number = false;
  bool no_filename = false;
  bool show_messages = false;
  bool only_matching = false;

  process_arguments(argc, argv, &regexp, &ignore_case, &invert_match,
                    &count_lines, &print_filenames, &print_line_number,
                    &no_filename, &show_messages, &only_matching);

  if (optind >= argc) {
    if (!show_messages) {
      printf("Error: pattern argument is missing.\n");
    }
    return 1;
  }

  const char* pattern = argv[optind];

  search_files(pattern, argc, argv, show_messages, print_filenames, count_lines,
               no_filename, ignore_case, invert_match, print_line_number,
               only_matching);

  return 0;
}
