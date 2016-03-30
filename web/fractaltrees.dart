import 'dart:html';
import 'dart:math';

Random rng = new Random();
double deg_to_rad = PI / 180.0;

void main() {
  drawForest();
  querySelector('#PlantTree').onClick.listen((e) => drawForest());
}

void drawForest() {
  CanvasElement ca = querySelector("#surface");
  CanvasRenderingContext2D crc = ca.getContext("2d");

  for (int i = 0; i < 25; i++) {
    int sc = 180 + (i * 4);
    crc.fillStyle = 'rgb(0, 0, $sc)';
    crc.fillRect(i * 10, (i * 10) + 10, 640 - i * 10, 240);
  }
  for (int i = 0; i < 25; i++) {
    int sc = 180 + (i * 4);
    crc.fillStyle = 'rgb(0, $sc, 0)';
    crc.fillRect(0, (i * 10) + 250, 640, 480);
  }

  drawTree(crc, 220, 350, -90, 8 + rng.nextInt(2), true, 6);
  drawTree(crc, 520, 420, -90, 6 + rng.nextInt(3), true, 4);
}

void drawTree(CanvasRenderingContext2D ctx, int x1, int y1, int angle,
    int depth, bool trunk, int scale) {
  if (depth > 0) {
    String c = '';
    double far = angle * deg_to_rad;
    int x2 = (x1 + ((cos(far) * depth * scale))).floor();
    int y2 = (y1 + ((sin(far) * depth * scale))).floor();

    if (trunk) {
      ctx.lineWidth = 14 + rng.nextInt(18);
      c = 'rgb(110, 0, 0)';
    } else {
      ctx.lineWidth = 6;

      c = 'rgb(0,101,  0)';
      if (depth < 4) {
        ctx.lineWidth = 4;
        c = 'rgb( 20, 121, 20)';
      }
    }

    ctx.strokeStyle = c;
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.closePath();
    ctx.stroke();

    drawTree(
        ctx, x2, y2, (angle - 20) - rng.nextInt(25), depth - 1, false, scale);
    drawTree(
        ctx, x2, y2, (angle + 20) + rng.nextInt(25), depth - 1, false, scale);
  }
}
