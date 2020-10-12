import processing.video.*; //<>//

enum Modes {
  CAPTURE, FILTER, FRAME
};
enum Filters {
  GLITCH, RED, GOTHAM, VIGNETTE, NATURE
};

Capture video;

int treshold = 0;
int saveNum;

Boolean captureMode = true;
Boolean appliedFilter = true;
Boolean fullMode = false;
Modes appMode;
Filters filterMode;

Button captureBtn;
Button redBtn;
Button gothamBtn;
Button glitchBtn;
Button natureBtn;
Button backBtn;
Button handleBtn;
Button saveBtn;
Button binBtn;

JSONObject json;
ImageFilter rgbFilters;
ImageFilter hsbFilters;
PImage rgbicon;
PImage captureIcon;
PImage backIcon;
PImage saveIcon;
PImage binIcon;
PImage doneIcon;
PImage bgIcon;
PImage frameIcon;
PImage glitchIcon;
PImage natureIcon;
PImage redIcon;
PImage handleIcon;
PImage sliderIcon;
PImage gothamIcon;
PImage saveTxt;
PImage deleteTxt;
PImage natureTxt;
PImage redTxt;
PImage glitchTxt;
PImage gothamTxt;

float r = 0;
float g = 0;
float b = 0;
float h = 0;
float s = 0;
float br= 0;

final String saveStr = "index"; 

float btnY = 250;
float btnY_2 = 250;

void setup() {
  size(640, 480);
  background(0);
  surface.setTitle("Camera Application");
  appMode= Modes.CAPTURE;
  // appliedFilter = false;
  String[] cameras = Capture.list();
  loadImages();
  createFilters();

  if (cameras.length == 0) {
    println("no camera avaliable");
    exit();
  } else {
    println("cameras avaliable");

    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  video = new Capture(this, width, height);
  video.start();
}

void loadImages() {
  captureIcon = loadImage("record_1.png");
  backIcon = loadImage("cross.png");
  binIcon = loadImage("bin.png");
  doneIcon = loadImage("checklist.png");
  saveIcon = loadImage("save.png");
  bgIcon = loadImage("bg.png");
  frameIcon = loadImage("frame.png");
  glitchIcon = loadImage("glitch_icon.png");
  redIcon = loadImage("red_icon.png");
  handleIcon = loadImage("handle.png");
  sliderIcon = loadImage("slider.png");
  gothamIcon = loadImage("gotham.png");
  natureIcon = loadImage("nature_1.png");
  saveTxt = loadImage("save-txt.png");
  deleteTxt = loadImage("delete-txt.png");
  gothamTxt = loadImage("gotham-txt.png");
  natureTxt = loadImage("nature-txt.png");
  redTxt = loadImage("red-txt.png");
  glitchTxt = loadImage("glitch-txt.png");

  frameIcon.resize(100, 100);
  saveTxt.resize(50, 50);
  deleteTxt.resize(50, 50);
  redTxt.resize(40, 40);
  glitchTxt.resize(40, 40);
  natureTxt.resize(40, 40);
  gothamTxt.resize(40, 40);
  gothamTxt.resize(40, 40);
}

void createFilters() {
  rgbFilters = new ImageFilter(video, true, "rgb", rgbicon, r, g, b, h, s, br );
  hsbFilters = new ImageFilter(video, false, "hsb", rgbicon, r, g, b, h, s, br );
}

void loadData() {
  json = loadJSONObject("data.json");
  saveNum  = json.getInt(saveStr);
}

// save current index to json file 
void saveData(String fileName) {
  save(fileName + saveNum + ".png" );
  json = new JSONObject();
  json.setInt(saveStr, saveNum);
  saveJSONObject(json, "data/data.json");
}

void captureEvent(Capture video) {
  if (captureMode) {
    video.read();
  }
}

void draw() {
  image(video, 0, 0);
  onAppMode();
}
void onAppMode() {
  switch(appMode) {
  case CAPTURE:
    if (!captureMode) {
      captureMode = true;
    }
    //closeApp();
    onCapture();
    break;
  case FILTER:
    btnY_2 = 250;
    appliedFilter = true;
    showUI();
    onFilter();
    backToCapture();
    indicateFilterOnHover();
    break;
  case FRAME:
    checkFilterMode();
    frameUI();
    backToCapture();
    break;
  default:
    onCapture();
    break;
  }
}

void checkFilterMode() {
  switch(filterMode) {
  case GLITCH:
    applyGlitchFilter();
    println("glitch");
    break;
  case RED:
    applyRedFilter();
    println("red filter");
    break;
  case GOTHAM:
    applyGothamFilter();
    println("gotham filter");
    break;
  case VIGNETTE:
    println("vignette filter");
    break;
  case NATURE:
    applyNatureFilter();
    println("nature filter");
    break;
  }
}

void onCapture() {
  captureBtn = new Button(captureIcon, "Capture", width/2, height/2 + 100, 70, 50);
  captureBtn.Draw( width/2 - 10, height/2 + 80, 64, true);
  btnY = 250;
  if (captureBtn.MouseIsOver() && mousePressed) {
    captureMode = false;
    appMode = Modes.FILTER;
  }
}

void indicateFilterOnHover() {
  image(frameIcon, mouseX, height/ 2 + 110);
}

void showUI() {
  handleBtn = new Button(handleIcon, "none", width/2 - 150, height/2 + 205, 30, 30);
  image(bgIcon, width/2 - 400, height/2 + 100);

  // filter texts 
  image(redTxt, width/2 + 80, height/2 + 210);
  image(natureTxt, width/2 - 230, height/2 + 210);
  image(gothamTxt, width/2 + 220, height/2 + 210);
  image(glitchTxt, width/2 - 80, height/2 + 210);
}

void onFilter() {
  redBtn = new Button(redIcon, "red", width/2 + 50, height/2 + 100, 100, 100);
  glitchBtn = new Button(glitchIcon, "glitch", width/2 - 100, height/2 + 100, 100, 100);
  gothamBtn = new Button(gothamIcon, "gotham", width/2 + 200, height/2 + 100, 100, 100);
  natureBtn = new Button(natureIcon, "nature", width/2 - 250, height/2 + 100, 100, 100);
  btnY = lerp(btnY, 110, 0.4);
  redBtn.Draw(width/2 + 50, height/2 + btnY, 100, false);
  glitchBtn.Draw( width/2 - 100, height/2 + btnY, 100, false);
  gothamBtn.Draw(width/2 + 200, height/2 + btnY, 100, false);
  natureBtn.Draw(width/2 - 250, height/2 + btnY, 100, false);
  hoverOverFilters();

  if (redBtn.MouseIsOver() && mousePressed) {
    filterMode = Filters.RED;
    appMode = Modes.FRAME;
  }

  if (glitchBtn.MouseIsOver() && mousePressed) {
    filterMode = Filters.GLITCH;
    appMode = Modes.FRAME;
  }

  if (gothamBtn.MouseIsOver() && mousePressed) {
    filterMode = Filters.GOTHAM;
    appMode = Modes.FRAME;
  }
  if (natureBtn.MouseIsOver() && mousePressed) {
    filterMode = Filters.NATURE;
    appMode = Modes.FRAME;
  }
}


void hoverOverFilters() {

  if (redBtn.MouseIsOver()) {
    loadPixels();
    video.loadPixels();
    rgbFilters.redFilter(200, video);
    updatePixels();
    video.updatePixels();
  }

  if (glitchBtn.MouseIsOver()) {
    loadPixels();
    video.loadPixels();
    rgbFilters.glitch(100, video);
    updatePixels();
    video.loadPixels();
  }

  if (gothamBtn.MouseIsOver()) {
    loadPixels();
    video.loadPixels();
    hsbFilters.gotham(-100, video);
    updatePixels();
    video.updatePixels();
  }

  if (natureBtn.MouseIsOver()) {
    loadPixels();
    video.loadPixels();
    hsbFilters.nature(75, video);
    updatePixels();
    video.updatePixels();
  }
}


void frameUI() {

  if (appliedFilter) {
    saveBtn = new Button(saveIcon, "save", width/2 + 10, height/2 + 129, 100, 100);
    binBtn = new Button(binIcon, "bin", width/2 - 80, height /2 + 130, 100, 100);
    btnY_2 = lerp(btnY_2, 130, 0.3);
    image(bgIcon, width/2 - 400, height/2 + 100);
    saveBtn.Draw(width/2 + 10, height/2 + btnY_2, 50, true);
    binBtn.Draw(width/2 - 80, height /2 + btnY_2, 50, true);
    image(saveTxt, width/2 + 10, height/2 + 180);
    image(deleteTxt, width/2 - 80, height /2 + 180);
    fullMode = true;
  }

  if (binBtn.MouseIsOver() && mousePressed) {
    appMode = Modes.CAPTURE;
    return;
  }

  if (saveBtn.MouseIsOver() && appliedFilter == true && fullMode == true && mousePressed) {
    image(video, 0, 0, width, height);
    appliedFilter = false;
    fullMode = false;
    saveImg("Screenshot"); 
    println("screen shot ");
    appMode = Modes.FILTER;
    return;
  }
}

void backToCapture() {
  backBtn = new Button(backIcon, "Back", width/2 - 300, height/2 - 200, 50, 50);
  backBtn.Draw( width/2 - 300, height/2 - 200, 32, true);
  if (backBtn.MouseIsOver() && mousePressed) {
    appMode = Modes.CAPTURE;
  }
}

void closeApp() {
  backBtn = new Button(backIcon, "Back", width/2 + 250, height/2 - 200, 50, 50);
  backBtn.Draw( width/2 + 250, height/2 - 200, 32, true);
  if (backBtn.MouseIsOver() && mousePressed) {
    exit();
  }
}

void applyGlitchFilter() {
  loadPixels();
  video.loadPixels();
  rgbFilters.glitch(100, video);
  updatePixels();
  video.updatePixels();
  //saveNum++;
  //saveData("Testing");
  //loadData();
  //appliedFilter = true;
  captureMode = false;
}

void applyGothamFilter() {
  loadPixels();
  video.loadPixels();
  hsbFilters.gotham(-100, video);
  updatePixels();
  video.updatePixels();
  captureMode = false;
}

void applyNatureFilter() {
  loadPixels();
  video.loadPixels();
  hsbFilters.nature(75, video);
  updatePixels();
  video.updatePixels();
  captureMode = false;
}

void applyRedFilter() {
  loadPixels();
  video.loadPixels();
  rgbFilters.redFilter(200, video);
  updatePixels();
  video.updatePixels();
  captureMode = false;
}

void saveImg(String imgName) {
  saveNum++;
  saveData(imgName);
  loadData();
}
