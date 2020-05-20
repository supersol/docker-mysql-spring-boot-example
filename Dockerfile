FROM openjdk:8
ADD . /buildDir
WORKDIR /buildDir
RUN ./mvnw clean install

FROM openjdk:8
COPY --from=0 /buildDir/target/users-mysql.jar users-mysql.jar
EXPOSE 8086
ENTRYPOINT ["java", "-jar", "users-mysql.jar"]
