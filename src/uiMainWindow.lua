local app = require("resources.app")
local serialex = require("ecluart.serialextension")
local ui = require("ui")
local uiex = require("ecluart.uiextension")

local gm = require("ecluart.gm") -- geometry manager
local vm = require("ecluart.vm") -- validation manager
local wm = require("ecluart.wm") -- widget manager

--#region Functions

local function isNotEmpty(value)
  value = string.trim(value)
  return not string.isempty(value)
end

local function isNotWhitespace(value)
  value = string.trim(value)
  return not string.iswhitespace(value)
end

local function isNotNil(value)
  return not isnil(value)
end

--#endregion

--#region Window

local Window = ui.Window("ecSerialLogger", "dialog", 600, 320)
Window.minwidth = 600
Window.minheight = 320
Window.title = app.NAME .. " - " .. app.VERSION

--#endregion

--#region Widgets TOP

local PortLabel = ui.Label(Window, "Port:")
local PortCombobox = ui.Combobox(Window, false, { "COM5" })
local UpdateButton = ui.Button(Window, "Update")
local StartButton = ui.Button(Window, "Start")
local StopButton = ui.Button(Window, "Stop")
local ClearButton = ui.Button(Window, "Clear")
local SaveButton = ui.Button(Window, "Save")

--#endregion

--#region Widgets BOTTOM

local LogFileEntry = uiex.FileEntry(Window, "", 0, 0, 580, 22)

--#endregion

--#region Widgets LEFT

local OutputEdit = ui.Edit(Window, "")

--#endregion

--#region Widgets RIGHT

local BaudrateLabel = ui.Label(Window, "Baudrate:")
local BytesizeLabel = ui.Label(Window, "Bytesize:")
local ParityLabel = ui.Label(Window, "Parity:")
local StopbitsLabel = ui.Label(Window, "Stopbits:")
local DTRModeLabel = ui.Label(Window, "DTR-Mode:")
local RTSModeLabel = ui.Label(Window, "RTS-Mode:")

local BaudrateCombobox = ui.Combobox(Window, serialex.baudrates)
local BytesizeCombobox = ui.Combobox(Window, serialex.bytesize)
local ParityCombobox = ui.Combobox(Window, serialex.parity)
local StopbitsCombobox = ui.Combobox(Window, serialex.stopbits)
local DTRModeCombobox = ui.Combobox(Window, serialex.dtrmode)
local RTSModeCombobox = ui.Combobox(Window, serialex.rtsmode)

local HelpHyperLink = uiex.HyperLink(Window, "\nHelp")
HelpHyperLink.link = app.WEBSITE

--#endregion

--#region GeometryManager TOP

Window.GM_TOP = gm.GeometryManager():TopLayout(Window, gm.DIRECTION.Left, 10, { 10, 10, 10, 10 }, 30)
Window.GM_TOP:add(PortLabel, gm.ALIGNMENT.Center)
Window.GM_TOP:add(PortCombobox, gm.ALIGNMENT.Center)
Window.GM_TOP:add(UpdateButton, gm.ALIGNMENT.Center)
Window.GM_TOP:add(StartButton, gm.ALIGNMENT.Center)
Window.GM_TOP:add(StopButton, gm.ALIGNMENT.Center)
Window.GM_TOP:add(ClearButton, gm.ALIGNMENT.Center)
Window.GM_TOP:add(SaveButton, gm.ALIGNMENT.Center)

--#endregion

--#region GeometryManager BOTTOM

Window.GM_BOTTOM = gm.GeometryManager():BottomLayout(Window, gm.DIRECTION.Left, 10, { 10, 10, 10, 10 }, 30)
Window.GM_BOTTOM:add(LogFileEntry, gm.ALIGNMENT.Center)

--#endregion

--#region GeometryManager LEFT

Window.GM_LEFT = gm.GeometryManager():SingleLayout(Window, gm.RESIZE.Both, 10, 50, 400, 220)
Window.GM_LEFT:add(OutputEdit)

--#endregion

--#region GeometryManager RIGHT

Window.GM_RIGHT1 = gm.GeometryManager():RightLayout(Window, gm.DIRECTION.Top, 10, { 10, 10, 50, 50 }, 100)
Window.GM_RIGHT1:add(BaudrateCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(BytesizeCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(ParityCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(StopbitsCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(DTRModeCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(RTSModeCombobox, gm.ALIGNMENT.Left)
Window.GM_RIGHT1:add(HelpHyperLink, gm.ALIGNMENT.Center)

Window.GM_RIGHT2 = gm.GeometryManager():RightLayout(Window, gm.DIRECTION.Top, 16, { 10, 120, 52, 50 }, 60)
Window.GM_RIGHT2:add(BaudrateLabel, gm.ALIGNMENT.Left)
Window.GM_RIGHT2:add(BytesizeLabel, gm.ALIGNMENT.Left)
Window.GM_RIGHT2:add(ParityLabel, gm.ALIGNMENT.Left)
Window.GM_RIGHT2:add(StopbitsLabel, gm.ALIGNMENT.Left)
Window.GM_RIGHT2:add(DTRModeLabel, gm.ALIGNMENT.Left)
Window.GM_RIGHT2:add(RTSModeLabel, gm.ALIGNMENT.Left)

--#endregion

--#region WidgetManager

Window.WM = wm.WidgetManager()
Window.WM:add(BaudrateCombobox, "BaudrateCombobox")
Window.WM:add(BytesizeCombobox, "BytesizeCombobox")
Window.WM:add(ClearButton, "ClearButton")
Window.WM:add(DTRModeCombobox, "DTRModeCombobox")
Window.WM:add(LogFileEntry, "LogFileEntry")
Window.WM:add(OutputEdit, "OutputEdit")
Window.WM:add(ParityCombobox, "ParityCombobox")
Window.WM:add(PortCombobox, "PortCombobox")
Window.WM:add(RTSModeCombobox, "RTSModeCombobox")
Window.WM:add(SaveButton, "SaveButton")
Window.WM:add(StartButton, "StartButton")
Window.WM:add(StopbitsCombobox, "StopbitsCombobox")
Window.WM:add(StopButton, "StopButton")
Window.WM:add(UpdateButton, "UpdateButton")

--#endregion

--#region WidgetManager PORT

Window.WM_PORT = wm.WidgetManager()
Window.WM_PORT:add(BaudrateCombobox, "BaudrateCombobox")
Window.WM_PORT:add(BytesizeCombobox, "BytesizeCombobox")
Window.WM_PORT:add(ClearButton, "ClearButton")
Window.WM_PORT:add(DTRModeCombobox, "DTRModeCombobox")
Window.WM_PORT:add(LogFileEntry, "LogFileEntry")
Window.WM_PORT:add(ParityCombobox, "ParityCombobox")
Window.WM_PORT:add(RTSModeCombobox, "RTSModeCombobox")
Window.WM_PORT:add(SaveButton, "SaveButton")
Window.WM_PORT:add(StartButton, "StartButton")
Window.WM_PORT:add(StopbitsCombobox, "StopbitsCombobox")
Window.WM_PORT:add(StopButton, "StopButton")
Window.WM_PORT:add(OutputEdit, "OutputEdit")

--#endregion

--#region WidgetManager START

Window.WM_START = wm.WidgetManager()
Window.WM_START:add(BaudrateCombobox, "BaudrateCombobox")
Window.WM_START:add(BytesizeCombobox, "BytesizeCombobox")
Window.WM_START:add(ClearButton, "ClearButton")
Window.WM_START:add(DTRModeCombobox, "DTRModeCombobox")
Window.WM_START:add(LogFileEntry, "LogFileEntry")
Window.WM_START:add(ParityCombobox, "ParityCombobox")
Window.WM_START:add(PortCombobox, "PortCombobox")
Window.WM_START:add(RTSModeCombobox, "RTSModeCombobox")
Window.WM_START:add(SaveButton, "SaveButton")
Window.WM_START:add(SaveButton, "SaveButton")
Window.WM_START:add(StartButton, "StartButton")
Window.WM_START:add(StopbitsCombobox, "StopbitsCombobox")
Window.WM_START:add(UpdateButton, "UpdateButton")

--#endregion

--#region WidgetManager SAVE

Window.WM_SAVE = wm.WidgetManager()
Window.WM_SAVE:add(SaveButton, "SaveButton")

--#endregion

--#region WidgetManager CLEAR

Window.WM_CLEAR = wm.WidgetManager()
Window.WM_CLEAR:add(ClearButton, "ClearButton")
Window.WM_CLEAR:add(OutputEdit, "OutputEdit")
--Window.WM_CLEAR:add(SaveButton, "SaveButton")

--#endregion

--#region WidgetManager STOP

Window.WM_STOP = wm.WidgetManager()
Window.WM_STOP:add(StopButton, "StopButton")

--#endregion

--#region WidgetManager RESIZE

Window.WM_RESIZE = wm.WidgetManager()
Window.WM_RESIZE:add(LogFileEntry, "LogFileEntry")

--#endregion

--#region ValidationManager SAVE

Window.VM_SAVE = vm.ValidationManager()
Window.VM_SAVE:add(LogFileEntry, "text", isNotEmpty, "is empty")
Window.VM_SAVE:add(LogFileEntry, "text", isNotWhitespace, "is whitespace")

--#endregion

--#region ValidationManager OUTPUT

Window.VM_OUTPUT = vm.ValidationManager()
Window.VM_OUTPUT:add(OutputEdit, "text", isNotEmpty, "is empty")

--#endregion

--#region ValidationManager PORT

Window.VM_PORT = vm.ValidationManager()
Window.VM_PORT:add(PortCombobox, "selected", isNotNil, "is nil")

--#endregion

Window.ButtonClear = ClearButton
Window.ButtonSave = SaveButton
Window.ButtonStart = StartButton
Window.ButtonStop = StopButton
Window.ButtonUpdate = UpdateButton
Window.ComboboxBaudrate = BaudrateCombobox
Window.ComboboxBytesize = BytesizeCombobox
Window.ComboboxDTRMode = DTRModeCombobox
Window.ComboboxParity = ParityCombobox
Window.ComboboxPort = PortCombobox
Window.ComboboxRTSMode = RTSModeCombobox
Window.ComboboxStopbits = StopbitsCombobox
Window.EditOutput = OutputEdit
Window.HyperLinkHelp = HelpHyperLink
Window.FileEntryLog = LogFileEntry

return Window
