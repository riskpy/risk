
import { cn } from "@/lib/utils";

export function Input({className, ...props}:{className?:string} & React.InputHTMLAttributes<HTMLInputElement>){
  return(
    <input
      className={cn("w-full px-3 py-2 rounded-lg bg-elevated border border-white/10 text-text-primary placeholder:text-text-secondary/50 outline-none focus:ring-2 focus:ring-brand-primary", className)}
      {...props}
    />
  );
}
