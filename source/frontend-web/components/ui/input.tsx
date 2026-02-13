import { cn } from "@/lib/utils";

export function Input({
  className,
  ...props
}: { className?: string } & React.InputHTMLAttributes<HTMLInputElement>) {
  return (
    <input
      className={cn(
        [
          "w-full px-3 py-2 rounded-lg",
          // Base (se ve editable en claro y oscuro)
          "bg-surface text-text-primary placeholder:text-text-secondary/60",
          // Borde y hover
          "border border-borderSubtle hover:border-borderSubtle/80",
          // Foco moderno y consistente
          "outline-none transition-colors",
          "focus:border-brand-primary focus:ring-2 focus:ring-brand-primary/30",
          // Disabled/readonly prolijo
          "disabled:opacity-60 disabled:cursor-not-allowed",
          "read-only:opacity-80 read-only:cursor-default",
        ].join(" "),
        className
      )}
      {...props}
    />
  );
}
