# https://github.com/insideapp-oss/sonar-flutter/releases

FROM sonarqube:latest

# กำหนดเวอร์ชันปลั๊กอิน
ENV PLUGIN_VERSION=0.5.3-SNAPSHOT
ENV PLUGIN_URL=https://github.com/insideapp-oss/sonar-flutter/releases/download/$PLUGIN_VERSION/sonar-flutter-plugin-$PLUGIN_VERSION.jar

# ดาวน์โหลดปลั๊กอินและคัดลอกไปที่ SonarQube
RUN curl -L $PLUGIN_URL -o /opt/sonarqube/extensions/plugins/sonar-flutter-plugin.jar

# กำหนด permission เพื่อให้ SonarQube ใช้งานได้
RUN chmod 644 /opt/sonarqube/extensions/plugins/sonar-flutter-plugin.jar
