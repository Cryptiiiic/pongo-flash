asm(".text\n");
extern long init(void);

long read_blockdev(void) {
  long image_info = init();
  return image_info;
}
