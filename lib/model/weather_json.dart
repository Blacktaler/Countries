class Weather {
    Weather({
        this.weather,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.timezone,
        this.id,
        this.name,
        this.cod,
    });
    List<WeatherElement>? weather;
    Main? main;
    int? visibility;
    Wind? wind;
    Clouds? clouds;
    int? timezone;
    int? id;
    String? name;
    int? cod;

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
    );

    Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "main": main!.toJson(),
        "visibility": visibility,
        "wind": wind!.toJson(),
        "clouds": clouds!.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
    };
}

class Clouds {
    Clouds({
        this.all,
    });

    int? all;

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}



class Main {
    Main({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
    });

    double? temp;
    double? feelsLike;
    double? tempMin;
    double? tempMax;
    int? pressure;
    int? humidity;

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"],
        feelsLike: json["feels_like"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
    };
}

class Sys {
    Sys({
        this.type,
        this.id,
        this.message,
        this.country,
        this.sunrise,
        this.sunset,
    });

    int? type;
    int? id;
    double? message;
    String? country;
    int? sunrise;
    int? sunset;

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        message: json["message"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "message": message,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class WeatherElement {
    WeatherElement({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    int? id;
    String? main;
    String? description;
    String? icon;

    factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    Wind({
        this.speed,
        this.deg,
    });

    double? speed;
    int? deg;

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"],
        deg: json["deg"],
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
    };
}
