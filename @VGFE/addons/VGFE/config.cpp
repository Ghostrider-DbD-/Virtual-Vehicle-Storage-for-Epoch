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
    class VGFE {
        build = 2.1;
        version = 0.6;
        date = "5-23-26";
    };
};

class CfgFunctions {
    class VGFE {
        class startUp {
            file="VGFE\init";
            //class preInit {
                //preInit = 1;
            //};
            class postInit {
                postInit = 1;
            };
        };
        class serverFunctionsVGFE {
            file="VGFE\server_functions";
            class getVGdata {};
            //class getVGkey {};
            class getVehicleCondition {};
            class getVehicleInventory {};
            class getVehicleLoadout {};       
            class handleClientRequest {};
            class onPlayerJoined {};
            class retrieveVehicle {};    
            class sendClientVGdata {};        
            class setVehicleCondition {};
            class setVehicleInventory {};
            class setVehicleLoadout {};
            class setVehicleTextures {};
            class spawnVehicle {};            
            class storeVGdata {};
            //class storeVGkey {};
            class storeVehicle {};
            class testSendRequest {};
            class log {};
        };
        class clientFunctionsVGFE {
            file="VGFE\client_functions";
            class client_accessVehicleGarage {};
            class client_canRetrieve {};
            class client_getLocalVehicles {};
           // class client_getNearbyJammers {};
            class client_onLbSelChangedLocalVehicleList {};
            class client_onLbSelChangedStoredVehicleList {};
            class client_onVirtualGarageDialogLoad {};
            class client_receiveClientVGData {};
            class client_retrieveVehicle {};
            class client_storeVehicle {};
            class client_vehicleRetrieved {};            
            //class client_log {};
        };
    };
};
