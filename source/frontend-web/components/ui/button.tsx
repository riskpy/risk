
import { cn } from "@/lib/utils";

export function Button({className, ...props}:{className?:string} & React.ButtonHTMLAttributes<HTMLButtonElement>){
  return(
    <button
      className={cn("px-4 py-2 rounded-lg bg-brand-primary text-white hover:bg-brand-secondary transition-colors", className)}
      {...props}
    />
  );
}
