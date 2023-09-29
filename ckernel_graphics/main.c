void putpixel(int x, int y, int color) {
  *(char *)(0xA0000 + 320 * y + x) = color;
}

int func(int x) {
  int y_aspect = (int)(x * 200) / 320;
  if (y_aspect < 0)
    return 0;
  if (y_aspect > 200)
    return 200;
  return 200 - y_aspect;
}

void kmain(int _i, int _j) {
  for (int j = 0; j < _j; j++)
    for (int x = 0; x < 320; x++) {
      int y_asp = func(x);
      int shift = (_i * _j) + j;
      putpixel(x, y_asp + shift, (_i + 1) % 256);
      putpixel(x, y_asp - shift, (_i + 1) % 256);
    }
}