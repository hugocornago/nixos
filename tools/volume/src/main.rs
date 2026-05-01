use std::{env, process::Command};

enum Sink {
    Monitor,
    Cascos,
}

/*
Name: alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3
Name: alsa_output.usb-Generic_USB_Audio-00.HiFi_7_1__SPDIF__sink
Name: alsa_output.usb-Generic_USB_Audio-00.HiFi_7_1__Headphones__sink
Name: alsa_output.usb-Generic_USB_Audio-00.HiFi_7_1__Speaker__sink
*/
impl From<String> for Sink {
    fn from(value: String) -> Self {
        if value.contains("hdmi-stereo") {
            Self::Monitor
        } else if value.contains("Headphones") {
            Self::Cascos
        } else {
            panic!("Unidentified device. {}", value.trim())
        }
    }
}

impl Into<String> for Sink {
    fn into(self) -> String {
        self.get_sink_name().unwrap()
    }
}

impl Sink {
    pub fn the_other_one(&self) -> Sink {
        match self {
            Self::Monitor => Self::Cascos,
            Self::Cascos => Self::Monitor,
        }
    }

    pub fn name(&self) -> &'static str {
        match self {
            Sink::Monitor => "Monitor",
            Sink::Cascos => "Headphones",
        }
    }

    pub fn get_sink_name(&self) -> Option<String> {
        let sinks: Vec<String> = String::from_utf8(
            Command::new("pactl")
                .arg("list")
                .arg("sinks")
                .output()
                .unwrap()
                .stdout,
        )
        .unwrap()
        .lines()
        .filter(|line| line.trim().starts_with("Name:"))
        .flat_map(|line| line.trim().strip_prefix("Name: "))
        .map(|line| line.to_string())
        .collect::<Vec<String>>();

        match self {
            Sink::Monitor => sinks
                .iter()
                .find(|sink| sink.contains("hdmi-stereo"))
                .cloned(),
            Sink::Cascos => sinks
                .iter()
                .find(|sink| sink.contains("Headphones"))
                .cloned(),
        }
    }
}

enum CommandOptions {
    SubirVolumen(u8),
    BajarVolumen(u8),
    CambiarSink,
    Mute,
}

impl CommandOptions {
    pub fn parse(mut arguments: env::Args) -> CommandOptions {
        arguments.next().unwrap();
        let name = arguments.next().expect("Please specify an argument.");
        match name.as_str() {
            "up" => {
                let incremento = arguments
                    .next()
                    .expect("Please specify an increment.")
                    .parse()
                    .expect("Please specify a number.");
                CommandOptions::SubirVolumen(incremento)
            }
            "down" => {
                let decremento = arguments
                    .next()
                    .expect("Please specify an increment.")
                    .parse()
                    .expect("Please specify a number.");
                CommandOptions::BajarVolumen(decremento)
            }
            "sink" => Self::CambiarSink,
            "mute" => Self::Mute,
            _ => panic!("Argument not recognized."),
        }
    }

    pub fn execute(self) {
        let active_sink: Sink = String::from_utf8(
            Command::new("pactl")
                .arg("get-default-sink")
                .output()
                .unwrap()
                .stdout,
        )
        .unwrap()
        .into();
        match self {
            CommandOptions::SubirVolumen(incremento) => {
                Command::new("pactl")
                    .arg("set-sink-volume")
                    .arg::<String>(active_sink.into())
                    .arg(format!("+{}%", incremento))
                    .output()
                    .unwrap();
            }
            CommandOptions::BajarVolumen(decremento) => {
                Command::new("pactl")
                    .arg("set-sink-volume")
                    .arg::<String>(active_sink.into())
                    .arg(format!("-{}%", decremento))
                    .output()
                    .unwrap();
            }
            CommandOptions::CambiarSink => {
                Command::new("pactl")
                    .arg("set-default-sink")
                    .arg::<String>(active_sink.the_other_one().get_sink_name().unwrap())
                    .output()
                    .unwrap();

                notify(format!("Sink: {}", active_sink.the_other_one().name()));
            }
            CommandOptions::Mute => {
                Command::new("pactl")
                    .arg("set-sink-mute")
                    .arg::<String>(active_sink.into())
                    .arg("toggle")
                    .output()
                    .unwrap();
            }
        }
    }
}

fn notify(msg: String) {
    Command::new("notify-send").arg(msg).output().unwrap();
}

fn main() {
    let command = CommandOptions::parse(env::args());
    command.execute();
}
