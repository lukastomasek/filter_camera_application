import processing.video.*;

public class ImageFilter {
  Boolean isRgb;
  float r;
  float g;
  float b;
  float h;
  float s;
  float br;
  String filterName;
  PImage icon;
  Capture video;

  ImageFilter(Capture _video, Boolean _isRgb, String _filterName, PImage _icon, float _r, float _g, float _b, 
    float _h, float _s, float _br) {
    video = _video;
    isRgb = _isRgb;
    filterName = _filterName;
    icon = _icon;
    r = _r;
    g = _g;
    b = _b;
    h = _h;
    s = _s;
    br = _br;

    if (isRgb) {
      colorMode(RGB);
    } else {
      colorMode(HSB);
    }
  }

  PImage iconUI() {
    return icon;
  }

  void redFilter(int value, Capture video) {

    for (int i = 0; i < video.pixels.length; i++) {
      r = red(pixels[i]);
      b = blue(pixels[i]);
      g = green(pixels[i]);

      pixels[i] =  color(r + value, g, b);
    }
  }

  void glitch(int value, Capture video) {
    for (int i = 0; i < video.pixels.length; i++) {
      h = hue(pixels[i]);
      s = saturation(pixels[i]);
      br = brightness(pixels[i]);

      pixels[i] =  color(h, s + value, br + value);
    }
  }

  void gotham(int value, Capture video) {
    for (int i = 0; i < video.pixels.length; i++) {
      h = hue(pixels[i]);
      s = saturation(pixels[i]);
      br = brightness(pixels[i]);

      pixels[i] =  color(h, s + value, br);
    }
  }

  void nature(int value, Capture video) {
    for (int i = 0; i < video.pixels.length; i++) {
      h = hue(pixels[i]);
      s = saturation(pixels[i]);
      br = brightness(pixels[i]);

      pixels[i] =  color(h + value, s, br + 10);
    }
  }

  void vignette(int value, Capture video) {
    for (int i = 0; i < video.pixels.length; i++) {
      r = red(pixels[i]);
      b = blue(pixels[i]);
      g = green(pixels[i]);

      pixels[i] =  color(r , g + value, b - value /2);
    }
  }
}
