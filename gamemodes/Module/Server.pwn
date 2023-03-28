











new ServerMoney,
    Material,
    MaterialPrice;

new MoneyPickup,
    Text3D:MoneyText;

CreateServerPoint()
{
    if (IsValidDynamic3DTextLabel(MoneyText))
        DestroyDynamic3DTextLabel(MoneyText);

    if (IsValidDynamicPickup(MoneyPickup))
        DestroyDynamicPickup(MoneyPickup);

    // Server Money
    new string[1024];
    MoneyPickup = CreateDynamicPickup(1239, 23, 2255.92, -1747.33, 1014.77, -1, -1, -1, 5.0);
    format(string, sizeof(string), "[server Money]\n"WHITE_E"Goverment Money: "LG_E"%s", FormatMoney(ServerMoney));
    MoneyText = CreateDynamic3DTextLabel(string, -1, 2255.92, -1747.33, 1014.77, 5.0);

}