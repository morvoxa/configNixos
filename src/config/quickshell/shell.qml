import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Variants {
  model: Quickshell.screens

  delegate: Component {
    PanelWindow {
      required property var modelData
      screen: modelData

      anchors { top: true; left: true; right: true }
      // Tinggi panel keseluruhan
      implicitHeight: 15
      color: "#09090b"

      // 1. KELOMPOK SEBELAH KIRI (JAM & WORKSPACE)
      RowLayout {
        id: leftGroup
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 1
        spacing: 4

        // 1A. JAM (Paling Kiri)
        Rectangle {
          height: 12
          width: clockContentLayout.width + 8
          color: "#18181b"
          border.color: "#3f3f46"
          border.width: 1
          radius: 6

          RowLayout {
            id: clockContentLayout
            anchors.centerIn: parent
            spacing: 2
            Text {
              text: "󱑍"
              color: "#a1a1aa"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8
            }
            Text {
              id: clockText
              text: "00:00"
              color: "#f4f4f5"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8

              Process {
                id: clockProc
                command: ["date", "+%H:%M"]
                running: true
                stdout: StdioCollector {
                  onStreamFinished: {
                    if (this.text) clockText.text = this.text.trim();
                  }
                }
              }

              Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: clockProc.running = true
              }
            }
          }
        }

        // 1B. WORKSPACE (Di sebelah kanan Jam)
        Rectangle {
          height: 12
          width: wsContentLayout.width + 8
          color: "#18181b"
          border.color: "#3f3f46"
          border.width: 1
          radius: 6

          RowLayout {
            id: wsContentLayout
            anchors.centerIn: parent
            spacing: 2
            Text {
              text: ""
              color: "#a1a1aa"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8
            }
            Text {
              id: wsText
              text: "1"
              color: "#f4f4f5"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8

              Process {
                id: wsProc
                command: ["sh", "-c", "
                  if command -v hyprctl >/dev/null 2>&1; then
                    hyprctl activeworkspace -j | jq '.id'
                  elif command -v niri >/dev/null 2>&1; then
                    niri msg -j workspaces | jq '.[] | select(.is_active) | .idx'
                  else
                    echo '1'
                  fi
                "]
                running: true
                stdout: StdioCollector {
                  onStreamFinished: {
                    let val = this.text ? this.text.trim() : "";
                    if (val !== "") wsText.text = val;
                  }
                }
              }

              Timer {
                interval: 200; running: true; repeat: true
                onTriggered: wsProc.running = true
              }
            }
          }
        }
      }

      // 2. KELOMPOK SEBELAH KANAN (TITLE & WIFI)
      RowLayout {
        id: rightGroup
        anchors.left: leftGroup.right
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 1
        spacing: 4

        // 2A. TITLE BAR (Di sebelah kanan Workspace)
        Rectangle {
          Layout.fillWidth: true
          height: 12
          color: "#18181b"
          border.color: "#3f3f46"
          border.width: 1
          radius: 6
          clip: true

          RowLayout {
            id: titleContentLayout
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 4
            spacing: 3

            Text {
              text: "~/"
              color: "#a1a1aa"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8
              Layout.alignment: Qt.AlignVCenter
            }
            Text {
              id: titleText
              text: "Desktop"
              color: "#f4f4f5"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8
              elide: Text.ElideRight
              Layout.fillWidth: true
              Layout.maximumWidth: 360

              Process {
                id: titleProc
                command: ["sh", "-c", "
                  if command -v hyprctl >/dev/null 2>&1; then
                    hyprctl activewindow -j | jq -r '.title // \"Desktop\"'
                  elif command -v niri >/dev/null 2>&1; then
                    niri msg -j windows | jq -r '.[] | select(.is_focused) | .title // \"Desktop\"'
                  else
                    echo 'Desktop'
                  fi
                "]
                running: true
                stdout: StdioCollector {
                  onStreamFinished: {
                    let val = this.text ? this.text.trim() : "";
                    if (val !== "") {
                      if (val.length > 60) {
                        titleText.text = val.substring(0, 57) + "...";
                      } else {
                        titleText.text = val;
                      }
                    }
                  }
                }
              }

              Timer {
                interval: 300; running: true; repeat: true
                onTriggered: titleProc.running = true
              }
            }
          }
        }

        // 2B. STATUS WIFI (Paling Kanan)
        Rectangle {
          height: 12
          width: wifiContentLayout.width + 8
          color: "#18181b"
          border.color: "#3f3f46"
          border.width: 1
          radius: 6

          RowLayout {
            id: wifiContentLayout
            anchors.centerIn: parent
            spacing: 2

            Text {
              id: wifiIconText
              text: "󰤨"
              color: "#a1a1aa"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8
            }
            Text {
              id: wifiText
              text: "Connected"
              color: "#f4f4f5"
              font.family: "SFMono Nerd Font"
              font.pixelSize: 8

              Process {
                id: wifiProc
                command: ["sh", "-c", "
                  if command -v nmcli >/dev/null 2>&1; then
                    ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2 | head -n 1)
                    if [ -n \"$ssid\" ]; then
                      echo \"$ssid\"
                    else
                      echo \"Disconnected\"
                    fi
                  else
                    echo \"N/A\"
                  fi
                "]
                running: true
                stdout: StdioCollector {
                  onStreamFinished: {
                    let val = this.text ? this.text.trim() : "";
                    if (val !== "") {
                      if (val === "Disconnected" || val === "N/A") {
                        wifiText.text = "Offline";
                        wifiIconText.text = "󰤭";
                      } else {
                        wifiText.text = val.length > 12 ? val.substring(0, 10) + "..." : val;
                        wifiIconText.text = "󰤨";
                      }
                    }
                  }
                }
              }

              Timer {
                interval: 5000; running: true; repeat: true
                onTriggered: wifiProc.running = true
              }
            }
          }
        }
      }
    }
  }
}
