abstract class DeviceStates{}

class DeviceInitState extends DeviceStates{}

class DeviceGetDataState extends DeviceStates{}
class DeviceUpdateState extends DeviceStates{}
class DeviceLoadingState extends DeviceStates{}

class MaintenanceGetState extends DeviceStates{}
class MaintenanceUpdateState extends DeviceStates{}
class MaintenanceLoadingState extends DeviceStates{}

class DepartmentGetState extends DeviceStates{}
class DepartmentUpdateState extends DeviceStates{}
class DepartmentLoadingState extends DeviceStates{}

class UserGetState extends DeviceStates{}
class UserUpdateState extends DeviceStates{}
class CurrentUserUpdateState extends DeviceStates{}

class GetSuppliersState extends DeviceStates{}
class UpdateSuppliersState extends DeviceStates{}
class SuppliersLoadingState extends DeviceStates{}

class GetStockState extends DeviceStates{}
class UpdateStockState extends DeviceStates{}
class StockLoadingState extends DeviceStates{}

class GetContractState extends DeviceStates{}
class UpdateContractState extends DeviceStates{}
class ContractLoadingState extends DeviceStates{}

class GetHistoryState extends DeviceStates{}
class UpdateHistoryState extends DeviceStates{}
class HistoryLodingState extends DeviceStates{}