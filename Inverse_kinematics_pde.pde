// Define the dimensions of the robot arm
float L1 = 100;
float L2 = 80;

// Define the joint angles
float theta1 = 0;
float theta2 = 0;

void setup() {
  size(600, 600);
}

void draw() {
  background(255);
  
  // Get the mouse position relative to the canvas center
  float x_target = mouseX - width/2;
  float y_target = mouseY - height/2;
  
  // Solve for the joint angles using trigonometric formulas
  float D = (x_target*x_target + y_target*y_target - L1*L1 - L2*L2) / (2*L1*L2);
  theta2 = atan2(sqrt(1 - D*D), D);
  theta1 = atan2(y_target, x_target) - atan2(L2*sin(theta2), L1 + L2*cos(theta2));
  
  // Calculate the end-effector position
  float x = L1*cos(theta1) + L2*cos(theta1 + theta2) + width/2;
  float y = L1*sin(theta1) + L2*sin(theta1 + theta2) + height/2;
  
  // Draw the robot arm
  stroke(0);
  strokeWeight(2);
  line(width/2, height/2, L1*cos(theta1) + width/2, L1*sin(theta1) + height/2);
  line(L1*cos(theta1) + width/2, L1*sin(theta1) + height/2, x, y);
  
  // Draw a line representing zero degree of the fixed joint
  stroke(150);
  line(width/2, height/2, width/2 + L1, height/2);
  
  // Draw the end-effector as a red circle
  noStroke();
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);
  
  // Draw the target position as a green circle
  noStroke();
  fill(0, 255, 0);
  ellipse(mouseX, mouseY, 10, 10);
  
  // Display joint angles next to the joints and other texts
  fill(0);
  textSize(12);
  text("θ1: " + degrees(theta1), width/2, height/2 + 20);
  text("θ2: " + degrees(theta2), L1*cos(theta1) + width/2, L1*sin(theta1) + height/2 - 10);
  text("Kinematic singularity occurs at joint angles of 0 and 180 degrees, ", 5, 550);
  text("where the mechanism loses mobility due to alignment constraints, ", 5, 570);
  text("potentially causing undesired behavior or limited motion capabilities.", 5, 590);
  textSize(16);
  text("Two-link Robotic arm Inverse Kinematics", 170 ,30 );
  
}
