function requiresConfirmation(action) {
  return ["transfer", "payment", "delete", "send"].includes(action);
}

function confirmAction(action, userConfirmed) {
  if (requiresConfirmation(action) && userConfirmed !== true) {
    return { status: "waiting_confirmation", message: "هل تؤكد تنفيذ هذا الإجراء؟" };
  }
  return { status: "approved", message: "تمت الموافقة على تنفيذ الإجراء." };
}

module.exports = { requiresConfirmation, confirmAction };
