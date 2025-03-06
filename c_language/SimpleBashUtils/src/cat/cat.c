#include "cat_func.h"

int main(int argc, char *argv[]) {
  int number_nonempty = 0;
  int show_ends = 0;
  int number_all = 0;
  int space_compress = 0;
  int tab_switch = 0;

  read_arguments(argc, argv, &number_nonempty, &show_ends, &number_all,
                 &space_compress, &tab_switch);

  for (int i = optind; i < argc; i++) {
    FILE *fp = fopen(argv[i], "r");
    if (fp != NULL) {
      print_lines(fp, number_nonempty, show_ends, number_all, space_compress,
                  tab_switch);

      close_file(fp);
    } else {
      printf("cat: %s: No such file or directory\n", argv[i]);
    }
  }
  return 0;
}
