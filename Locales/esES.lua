local addonName, ns = ...
local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then return end
local L = ns.L

L.Description  = "Indicador de Sigilo"
L.ReleaseNotes = "Notas de VersiÃƒÂ³n"
L.Reset        = "Restablecer Valores"

L.Stealth     = "Sigilo"
L.ShadowDance = "Danza de las Sombras"

L.Settings = "Ajustes"
L.Messages = "Mensajes"

L.EnableOnStealth     = "Activar en Sigilo"
L.EnableOnShadowDance = "Activar en Danza de las Sombras"

L.FloatingText  = "Texto Flotante"
L.IndicatorIcon = "Icono Indicador"
L.ScreenColor   = "Color de Pantalla"
L.Vignette      = "ViÃƒÂ±eta"
L.Highlight     = "Resaltar"
L.Appearance    = "Apariencia"

L.Enable     = "Habilitar"
L.Color      = "Color"
L.Size       = "TamaÃƒÂ±o"
L.Opacity    = "Opacidad"
L.OffsetX    = "Desplazamiento X"
L.OffsetY    = "Desplazamiento Y"
L.Thickness  = "Grosor"
L.CustomText = "Texto Personalizado"
L.Style      = "Estilo"
L.Layer      = "Capa"

L.DefaultMessage     = "SIGILO"
L.ShadowDanceMessage = "DANZA DE LAS SOMBRAS"

L.ShroudOfConcealment = "Sudario del Ocultamiento"
L.Countdown           = "Cuenta regresiva en Chat"
L.ChatChannel         = "Canal de Chat"
L.ShroudMessage       = "Mensaje de Cuenta Regresiva"
L.ShroudInterval      = "Modo Intervalo"
L.ShroudIntervalDesc  = "Solo al inicio, cada 5s y los últimos 5s"
L.ShroudOnStart       = "Mensaje Inicial"
L.ShroudOnEnd         = "Mensaje Final"
L.TimeRemainingHint   = "%t = tiempo restante"
