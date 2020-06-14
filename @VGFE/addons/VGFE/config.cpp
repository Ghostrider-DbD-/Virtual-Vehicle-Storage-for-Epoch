/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

class CfgPatches {
	class VGFE {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {
           // "epoch_server",
            //"a3_epoch_code"
        };
	};
};

class CfgBuild {
    class VirturalGarage {
        build = 1;
        version = 0.1;
        date = "6-2-20";
    };
};

class CfgFunctions {
    class VGFE {
        class startUp {
            file="VGFE\init";
            class preInit {
                //preInit = 1;
            };
            class postInit {
                postInit = 1;
            };
        };
        class serverFunctionsVGFE {
            file="VGFE\server_functions";
            class handleClientRequest {};
            class onPlayerJoined {};
            class getVehicleTexttures {};
            class getVehicleCondition {};
            class getVehicleLoadout {};
            class getVehicleLocation {};
            class getVehicleInventory {};
            /*                        */
            class setVehicleCondition {};
            class setVehicleLoadout {};
            class setVehicleLocation {};
            class setVehicleTexttures {};
            class setVehicleInventory {};
            /*                          */
            class storeVehicle {};
            class retrieveVehicle {};
            class testSendRequest {};
            class log {};
        };
        class clientFunctionsVGFE {
            file="VGFE\client_functions";
            class client_accessVehicleGarage {};
            class client_getLocalVehicles {};
            class client_getNearbyJammers {};
            class client_isBuildOwner {};
            class client_onLbSelChangedLocalVehicleList {};
            class client_onLbSelChangedStoredVehicleList {};
            class client_onVirtualGarageDialogLoad {};
            class client_setFocusOnLocalVehicleList {};
            class client_setFocusOnStoredVehicleList {};
            class client_retrieveVehicle {};
            class client_storeVehicle {};
            class client_init {};
            class client_log {};
        };
    };
};
