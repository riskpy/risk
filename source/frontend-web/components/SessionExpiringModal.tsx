"use client";

import { motion, AnimatePresence } from "framer-motion";

type Props = {
  open: boolean;
  secondsRemaining: number;
  onRefresh: () => void;
  onDismiss: () => void;
  onIgnore?: () => void;
};

export default function SessionExpiringModal({
  open,
  secondsRemaining,
  onRefresh,
  onDismiss,
  onIgnore,
}: Props) {
  return (
    <AnimatePresence>
      {open && (
        <motion.div
          className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/40 backdrop-blur-sm"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
        >
          {/* CARD */}
          <motion.div
            className="relative bg-elevated border border-borderSubtle rounded-xl p-6 w-full max-w-sm shadow-xl z-[10000]"
            initial={{ scale: 0.85, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.85, opacity: 0 }}
          >
            {/* X BUTTON */}
            <button
              onClick={onIgnore}
              className="absolute top-3 right-3 text-text-secondary hover:text-white text-lg z-[10001]"
            >
              ✕
            </button>

            <h2 className="text-lg font-semibold mb-2 text-text-primary">
              Sesión por caducar
            </h2>

            <p className="text-text-secondary text-sm mb-4">
              Tu sesión caduca en{" "}
              <span className="font-bold text-brand-primary">
                {secondsRemaining} segundos
              </span>
              . ¿Deseas renovarla?
            </p>

            <div className="flex justify-end gap-3 mt-6">
              <button
                onClick={onDismiss}
                className="px-3 py-1.5 rounded-lg text-sm border border-borderSubtle hover:bg-surface"
              >
                Cerrar sesión
              </button>

              <button
                onClick={onRefresh}
                className="px-4 py-1.5 rounded-lg bg-brand-primary text-white text-sm hover:bg-brand-primary/90"
              >
                Renovar
              </button>
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
