const int ledPin = 13;    // the number of the LED pin
const int buttonPin = 2;  // the number of the pushbutton pin

int buttonState = 0;
int i = 0;

void setup() {
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
}

void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);
  Serial.println(buttonState);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    i++;
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
    i = 0;
  }

//  delay(i * 1000);
//  digitalWrite(ledPin, LOW);
}
