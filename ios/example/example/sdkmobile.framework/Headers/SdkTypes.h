#ifndef SDKTYPES_H
#define SDKTYPES_H

typedef enum _CallDirection {
    CD_Outgoing,
    CD_Incoming
} CallDirection;

typedef enum _ActivationError {
    AE_Unknown,
    AE_BadCredentials,
    AE_EmptyCredentials,
    AE_NoResponse,
    AE_AddressIncomplete,
    AE_InternalServerError
} ActivationError;

typedef enum _CallError {
    CE_Unknown,
    CE_NotAvailable,
    CE_Busy,
    CE_Declined,
    CE_Disconnected,
    CE_AddressIncomplete,
    CE_WrongNumber,
    CE_Forbidden,
    CE_TemporarilyUnavailable
} CallError;
#endif
