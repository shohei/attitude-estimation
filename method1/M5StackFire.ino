#define M5STACK_MPU6886 
#include <M5Stack.h>
#include <ArduinoJson.h>
#include "Preferences.h"
#include "math.h"
#include "bmm150.h"
#include "bmm150_defs.h"

Preferences prefs;

struct bmm150_dev dev;
bmm150_mag_data mag_offset;
bmm150_mag_data mag_max;
bmm150_mag_data mag_min;

float accX = 0.0F;
float accY = 0.0F;
float accZ = 0.0F;

float gyroX = 0.0F;
float gyroY = 0.0F;
float gyroZ = 0.0F;

StaticJsonDocument<200> doc;
int8_t i2c_read(uint8_t dev_id, uint8_t reg_addr, uint8_t *read_data, uint16_t len)
{
    if(M5.I2C.readBytes(dev_id, reg_addr, len, read_data))
    {
        return BMM150_OK;
    }
    else
    {
        return BMM150_E_DEV_NOT_FOUND;
    }
}

int8_t i2c_write(uint8_t dev_id, uint8_t reg_addr, uint8_t *read_data, uint16_t len)
{
    if(M5.I2C.writeBytes(dev_id, reg_addr, read_data, len))
    {
        return BMM150_OK;
    }
    else
    {
        return BMM150_E_DEV_NOT_FOUND;
    }
}

int8_t bmm150_initialization()
{
    int8_t rslt = BMM150_OK;

    /* Sensor interface over SPI with native chip select line */
    dev.dev_id = 0x10;
    dev.intf = BMM150_I2C_INTF;
    dev.read = i2c_read;
    dev.write = i2c_write;
    dev.delay_ms = delay;

    /* make sure max < mag data first  */
    mag_max.x = -2000;
    mag_max.y = -2000;
    mag_max.z = -2000;

    /* make sure min > mag data first  */
    mag_min.x = 2000;
    mag_min.y = 2000;
    mag_min.z = 2000;

    rslt = bmm150_init(&dev);
    dev.settings.pwr_mode = BMM150_NORMAL_MODE;
    rslt |= bmm150_set_op_mode(&dev);
    dev.settings.preset_mode = BMM150_PRESETMODE_ENHANCED;
    rslt |= bmm150_set_presetmode(&dev);
    return rslt;
}

void bmm150_offset_save()
{
    prefs.begin("bmm150", false);
    prefs.putBytes("offset", (uint8_t *)&mag_offset, sizeof(bmm150_mag_data));
    prefs.end();
}

void bmm150_offset_load()
{
    if(prefs.begin("bmm150", true))
    {
        prefs.getBytes("offset", (uint8_t *)&mag_offset, sizeof(bmm150_mag_data));
        prefs.end();
        Serial.printf("bmm150 load offset finish.... \r\n");
    }
    else
    {
        Serial.printf("bmm150 load offset failed.... \r\n");
    }
}

void setup() {
  M5.begin();
  Wire.begin(21, 22, 400000);

  M5.IMU.Init();

    if(bmm150_initialization() != BMM150_OK)
    {
        for(;;)
        {
            delay(100);
        }
    }
    bmm150_offset_load();

}

void loop() {
  bmm150_read_mag_data(&dev);
  M5.IMU.getGyroData(&gyroX,&gyroY,&gyroZ);
  M5.IMU.getAccelData(&accX,&accY,&accZ);
  
  doc["accX"] = accX;
  doc["accY"] = accY;
  doc["accZ"] = accZ;
  doc["gyroX"] = gyroX;
  doc["gyroY"] = gyroY;
  doc["gyroZ"] = gyroZ;
  
  doc["magX"] = dev.data.x-mag_offset.x;
  doc["magY"] = dev.data.y-mag_offset.y;
  doc["magZ"] = dev.data.z-mag_offset.z;

  doc["t"] = millis();
  
  serializeJson(doc, Serial);
  Serial.println();

  delay(500);
}