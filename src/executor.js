const { requiresConfirmation } = require("./confirmation");

function executeAction(action, userConfirmed = false) {
  if (requiresConfirmation(action) && userConfirmed !== true) {
    return { status: "blocked", message: "تم إيقاف الإجراء: يلزم تأكيد المستخدم أولًا." };
  }
  return { status: "executed", message: "تم تنفيذ الإجراء بعد الموافقة." };
}

module.exports = { executeAction };
