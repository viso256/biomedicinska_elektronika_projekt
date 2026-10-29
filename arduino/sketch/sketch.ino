#include <Statistic.h>
#include <mcp3201.h>

const byte csPin = 10;                      //  CS pin to select MCP3201

MCP3201 myMCP3201(csPin);

void loop_basic(void);
void loop_stats(void);

void setup() {
  Serial.begin(9600);

}

void loop() {
  loop_stats();
}

void loop_basic() {
  int ADCvalue = myMCP3201.readAdc();       //  read 12bit ADC
  //  Digital Output Code

  Serial.print(">ADC:");
  Serial.println(ADCvalue);

  delay(1000);  //  not necessary, but if you wish less frequent print out

}

statistic::Statistic<float, uint32_t, true> myStats;

void loop_stats() {
  int ADCvalue = myMCP3201.readAdc();       //  read 12bit ADC
  myStats.add((long)ADCvalue);
  delay(100);
  if (myStats.count() == 100)
  {
    Serial.print("        Count: ");
    Serial.println(myStats.count());
    Serial.print("          Min: ");
    Serial.println(myStats.minimum(), 4);
    Serial.print("          Max: ");
    Serial.println(myStats.maximum(), 4);
    Serial.print("      Average: ");
    Serial.println(myStats.average(), 4);
    Serial.print("     variance: ");
    Serial.println(myStats.variance(), 4);
    Serial.print("    pop stdev: ");
    Serial.println(myStats.pop_stdev(), 4);
    Serial.print(" unbias stdev: ");
    Serial.println(myStats.unbiased_stdev(), 4);
    Serial.println("=====================================");
    myStats.clear();
    delay(1000);
  }
}
