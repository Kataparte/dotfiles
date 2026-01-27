// A simple button for your Bar
const PowerMenuButton = () => Widget.Button({
    on_primary_click: () => App.toggleWindow("powermenu"),
    child: Widget.Label(""),
});

// The actual dropdown/popup
const PowerMenu = Widget.Window({
    name: "powermenu",
    visible: false,
    anchor: ["top", "right"],
    child: Widget.Box({
        vertical: true,
        children: [
            Widget.Button({ child: Widget.Label("Shutdown"), on_clicked: () => Utils.exec("systemctl poweroff") }),
            Widget.Button({ child: Widget.Label("Reboot"), on_clicked: () => Utils.exec("systemctl reboot") }),
            Widget.Button({ child: Widget.Label("Log Out"), on_clicked: () => Utils.exec("hyprctl dispatch exit") }),
        ]
    })
});
