PShader clouds;
PShader party;
PShader currentShader;
int currentFilter;
float rotation = 0;

PImage BG;
final int NONE = 404;
final int LEVELS = 5;

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
  BG = loadImage("180.jpg");
  BG.resize(width, height);
  clouds = loadShader("clouds.glsl");
  party = loadShader("inv.glsl");
}

void draw() { 
  background(BG);
  translate(width/2, height/2);
  rotateY(radians(rotation));
  rotation++;
  stroke(0);
  fill(0, 255, 0);
  box(100);
  showShader();
}

void keyPressed() {
  switch(key) {
  case '1':
    setShader(null);
    break;
  case '2':
    setShader(GRAY);
    break;
  case '3':
    setShader(INVERT);
    break;
  case '4':
    setShader(THRESHOLD);
    break;
  case '5':
    setShader(POSTERIZE);
    break;
  case '6':
    setShader(BLUR);
    break;
  case '7':
    setShader(ERODE);
    break;
  case '8':
    setShader(DILATE);
    break;
  case '9':
    setShader(clouds);
    break;
  case '0':
    setShader(party);
    break;
  }
}

void setShader(int filter) {
  currentShader = null;
  currentFilter = filter;
}

void setShader(PShader shader) {
  currentFilter = NONE;
  currentShader = shader;
}

void showShader() {
  if (currentFilter == POSTERIZE || currentFilter == BLUR) {
    showShader(LEVELS); 
    return;
  }
  resetShader();
  if (currentFilter != NONE && currentShader == null) {
    filter(currentFilter);
  } else if (currentShader != null && currentFilter == NONE) {
    currentShader.set("u_resolution", float(width), float(height));
    currentShader.set("u_time", millis() / 1000.0);
    shader(currentShader);
  }
}

void showShader(int levels) {
  resetShader();
  if (currentFilter != NONE && currentShader == null) filter(currentFilter, levels);
  else if (currentShader != null && currentFilter == NONE) {
    currentShader.set("u_resolution", float(width), float(height));
    currentShader.set("u_time", millis() / 1000.0);
    shader(currentShader);
  }
}
